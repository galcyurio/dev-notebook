# Groovy GString strange behavior

## Issue summary
GString has some getters.  
So I was troubled this problem.  
In this time, I realized GString should not be used like String use cases.

## Environment (integrated library, OS, etc)
- Spring Boot 1.5.7.RELEASE
- Groovy 2.4.12
- Java 1.8

## Expected behavior
````json
{
  "message": "Request method 'GET' not supported please request using supported methods",
  "supportedMethods": [
    "POST"
  ]
}
````

## Actual behavior
````json
{
	"message": {
		"values": [
			"GET"
		],
		"strings": [
			"Request method '",
			"' not supported please request using supported methods"
		],
		"bytes": "UmVxdWVzdCBtZXRob2QgJ0dFVCcgbm90IHN1cHBvcnRlZCBwbGVhc2UgcmVxdWVzdCB1c2luZyBzdXBwb3J0ZWQgbWV0aG9kcw==",
		"valueCount": 1
	},
	"supportedMethods": [
		"POST"
	]
}
````


## Issue detail (Reproduction steps, use case)
````groovy
@ControllerAdvice
class ErrorControllerAdvice extends ResponseEntityExceptionHandler {
    // ...
    @Override
    protected ResponseEntity<Object> handleHttpRequestMethodNotSupported(HttpRequestMethodNotSupportedException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        def body = [
                message         : "Request method '${ex.method}' not supported please request using supported methods",
                supportedMethods: ex.supportedMethods
        ]
        return new ResponseEntity<>(body, status)
    }
    // ...
}
````

## Trouble shooting
This problem begin from getter of GString.  
Maybe this problem will also occur elsewhere which use getter.  
Solution is simple. Just convert GString to String.

````groovy
def body = [
        message         : "Request method '${ex.method}' not supported please request using supported methods".toString(),    // GString.toString()
        supportedMethods: ex.supportedMethods
]
````

I hope this post helps you.

## TL;DR
Convert GString to String using GString.toString()