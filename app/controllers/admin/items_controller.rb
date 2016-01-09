class Admin::ItemsController < AdminController

  # list of all items
  def index
    respond_to do |format|
      format.html
      format.json { render json: ItemDatatable.new(view_context)}
    end
  end

  # get /items/actualization
  def actualization
    @actualizations = ActualizationLog.order('created_at DESC').first(3)
  end

  def actualize
    file_path = save_uploaded_file params[:file]
    @log = ActualizationLog.create(status: 'Accepted')
    CsvImporter::ItemsImporter.new.delay.actualize(file_path, @log)

    @actualizations = ActualizationLog.order('created_at DESC').last(3)
    @table = Time.now.strftime('%Y-%m-%d')
    redirect_to action: 'actualization'
  end

  def save_uploaded_file(file)
    name = "actualization#{Digest::MD5.hexdigest(Time.now.to_s)}"
    directory = 'public/actualizations'
    path = File.join(directory, name)
    File.open(path,'wb') { |f| f.write(file.read) }
    path
  end

end
