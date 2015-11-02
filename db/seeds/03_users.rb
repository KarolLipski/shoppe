Admin
User.create(
        name: 'admin',
        email: 'admin@gmail.com',
        login: 'admin',
        password: 'xxx',
        password_confirmation: 'xxx'
)

@connection = ActiveRecord::Base.establish_connection(:madej_old)
sql = "SELECT * FROM ODB"

@result = @connection.connection.execute(sql)
@connection = ActiveRecord::Base.establish_connection(Rails.env)

@result.each(:as => :hash) do |row|
  if !row["LOGIN"].blank? && !row["NAZWA"].blank?
          User.create!(
              name: row["NAZWA"],
              login: row["LOGIN"],
              password: row["PASS"],
              password_confirmation: row["PASS"]
          )
    puts row.inspect
  end
end
