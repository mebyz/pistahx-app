var fs = require("fs");
var yaml = require('js-yaml');
var assert = require('assert');
var swaggerTest = require('swagger-test');
var dn = __dirname;

var swagger = yaml.safeLoad(fs.readFileSync('../../app/api.yaml', 'utf8'));
var xamples = swaggerTest.parse(swagger);

var preq = require('preq');

describe('specification-driven tests', function () {
  this.timeout(10000);

  xamples.forEach(function (xample) {
    var uri = xample.request.uri;
    xample.request.uri = 'http://' + uri
    console.log(xample.description);
    it(xample.description, function(done) {
      return preq[xample.request.method](xample.request)
      .then(function (response) {
	      assert.deepEqual(response.status, xample.response.status);
        assert.deepEqual(response.body, xample.response.body);
        done();
      })
      .catch(function(err) {
        //console.log(err);
        if (xample.description =='fail to auth user' && err.message == '401')
        {
            assert.deepEqual(1, 1);
        } else {
            console.log(xample.description);
            console.log(err);
            assert.deepEqual(0, 1);    
        }
        done();
      });
      done();   
    });
  });
});
