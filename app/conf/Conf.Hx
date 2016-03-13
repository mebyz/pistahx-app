class Conf {

  public  var APP_NAME : String;
  public  var ELK_SERVER : String;
  public  var REDIS_HOST : String;      
  public  var REDIS_PORT: Int;      
  public  var DB_HOST: String;         
  public  var DB_USER: String;         
  public  var DB_OPTIONS: Dynamic;         
  public  var DB_PASSWORD: String;     
  public  var DB_NAME: String;         
  public  var SESSION_TTL: Int;     
  public  var BASE_URL: String;        
  public  var API_PORT: Int;        
  public  var API_ROUTE_STATUS: String;

  public static function main() { trace('loading LOCAL conf'); }

  public function new(env : String, envArgs: Dynamic = null) {

    if (env == 'local') {
      APP_NAME      = 'orms_sample_app';
      //ELK_SERVER      = '[YOUR_ES_SERVER_HOST]';
      REDIS_HOST      = 'localhost';
      REDIS_PORT      = 6379;
      DB_HOST         = null;
      DB_USER         = null;
      DB_PASSWORD     = null;
      DB_NAME         = null;
      DB_OPTIONS      = {
                          dialect: 'sqlite',
                          storage: '../db.sqlite',
                          dialectOptions: {
                            encrypt: true
                          }, logging: false
                        };
      SESSION_TTL     = 3600; //secs
      BASE_URL        = '/api/v1';
      API_PORT        = 3000;
      API_ROUTE_STATUS= '/users/me/status';
    }

   if (env == 'docker') {
      REDIS_HOST = envArgs.ORMS_REDIS_PORT_6379_TCP_ADDR;
      REDIS_PORT = envArgs.ORMS_REDIS_PORT_6379_TCP_PORT;
      DB_HOST         = null;
      DB_USER         = null;
      DB_PASSWORD     = null;
      DB_NAME         = null;
      DB_OPTIONS      = {
                          dialect: 'sqlite',
                          storage: '../db.sqlite',
                          dialectOptions: {
                            encrypt: true
                          }, logging: false
                        };
      SESSION_TTL     = 3600; //secs
      BASE_URL        = '/api/v1';
      API_PORT        = 3000;
      API_ROUTE_STATUS= '/users/me/status';
    }

    if (env == 'production') {
      REDIS_HOST      = 'to be defined';
      REDIS_PORT      = 6379;
      DB_HOST         = 'to be defined';
      DB_USER         = 'to be defined';
      DB_PASSWORD     = 'to be defined';
      DB_NAME         = 'to be defined';
      DB_OPTIONS      = {
                          dialect: 'mssql',
                          pool: {
                            max: 5,
                            min: 0,
                            idle: 10000
                          },
                          dialectOptions: {
                            encrypt: true
                          }, logging: false
                        };
      SESSION_TTL     = 3600; //secs
      BASE_URL        = 'to be defined';
      API_PORT        = 8081;
      API_ROUTE_STATUS= 'to be defined';
    }

  }
}
