class ItemActualizator
  include Rails.application.routes.url_helpers

  attr_accessor :params

  def initialize(params)
    @params = params
  end

  #Actualize items from Csv
  def actualize_from_csv
    file_path = save_file(@params[:file],@params[:type])
    importer = get_importer(@params[:type])
    importer.offer_id = @params[:offer_id] if @params[:offer_id]
    log = create_log
    importer.delay.actualize(file_path, log)

  end

  #Return proper importer engine
  def get_importer(type)
    return CsvImporter.const_get("#{type}Importer").new
  end

  #Saves actualization file
  def save_file(file, type)
    name = "actualization#{type}_#{Time.now.to_s}"
    directory = 'public/actualizations'
    path = File.join(directory, name)
    File.open(path,'wb') { |f| f.write(file.read) }
    path
  end

  #Creates Actualization log
  def create_log
    ActualizationLog.create(status: 'Accepted', log_type: @params[:type])
  end

  #Return name of template if any errors
  def error_template
    return (params[:type] == 'Items') ? 'actualization': 'admin/offers/actualization'
  end

  # Returns success redirect path after actualize
  def success_redirect
    return (params[:type] == 'Items') ? admin_items_actualization_path : admin_offers_actualization_path(offer_id: params[:offer_id])
  end

  #Returns how many last logs should be displayed
  def log_count
    return (params[:type] == 'Items') ? 3 : 1
  end

end