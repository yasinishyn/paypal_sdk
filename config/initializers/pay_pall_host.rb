if Rails.env.production?
  HOST_WO_HTTP = 'www.agrime.it'
else
  HOST_WO_HTTP = 'localhost:3000'
end
HOST = "http://#{HOST_WO_HTTP}"