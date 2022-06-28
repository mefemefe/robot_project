import json
import requests
from tests.common.api.exceptions.InvalidExpectedStatus import InvalidExpectedStatus

try:
    from robot.libraries.BuiltIn import BuiltIn
    from robot.libraries.BuiltIn import _Misc
    import robot.api.logger as logger
    from robot.api.deco import keyword
    ROBOT = False
except Exception:
    ROBOT = False

class request_own_library():
    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'
    base_url = ""
    session = requests.Session()
    
    @keyword('Create Session')
    def create_session(self, base_url, headers):
        self.base_url = base_url
        self.session.headers.update(headers)

    def do_request(self, method, endpoint, payload=None):
        """Send REST request to the specified endpoint.
        :param method:    str   Request method name such as GET, POST, PUT, DELETE, PATCH
        :param endpoint:  str   Endpoint of service to which the request will be sent
        :param payload:   dict  Data or payload send along with the REST request
        :return: Tuple that contains the status code and the response.
        """
        
        endpoint_url = f"{self.base_url}/{endpoint}"

        if method in ['POST', 'PUT']:
            response = self.session.request(method, endpoint_url, data=json.dumps(payload))
        else:
            response = self.session.request(method, endpoint_url)

        if not response.ok:
            return response.status_code, response.text

        return response.status_code, response
    @keyword('GET On Session')
    def get_request(self, endpoint, expected_status_code ):
        """Method to send GET requests to the specified endpoint
        :param endpoint:  str   Endpoint of service to which the request will be sent
        :param expected_status_codet:  str   Expected status code
        :return:  the response.
        """
        expected = expected_status_code[len(expected_status_code)-3:]
        
        status_code, response = self.do_request('GET', endpoint)
        if int(status_code) == int(expected)  :
            return response
        else:
            raise InvalidExpectedStatus("the expected status code were not equal to the recived one")

            
    @keyword('POST On Session')
    def post_request(self, endpoint,  expected_status_code, **kwargs):
        """Method to send POST requests to the specified endpoint
        :param endpoint:  str   Endpoint of service to which the request will be sent
        :param expected_status_code:  str   Expected status code
        :param kwargs:    dict  Data that will be considered as Payload
        :return:  the response.
        
        """ 
        payload1 ={}
        for key, value in kwargs.items():
            payload1[key]= value

        expected = expected_status_code[len(expected_status_code)-3:]        
        status_code, response = self.do_request('POST', endpoint, payload1 )
        if int(status_code) == int(expected)  :
            return response
        else:
            raise InvalidExpectedStatus("the expected status code were not equals to the recived one")

    @keyword('PUT On Session')
    def put_request(self, endpoint,  expected_status_code, **kwargs):
        """Method to send PUT requests to the specified endpoint
        :param endpoint:  str   Endpoint of service to which the request will be sent
        :param expected_status_codet:  str   Expected status code
        :param kwargs:    dict  Data that will be considered as Payload
        :return:  the response.
        
        """ 
        payload1 ={}
        for key, value in kwargs.items():
            payload1[key]= value

        expected = expected_status_code[len(expected_status_code)-3:]        
        status_code, response = self.do_request('PUT', endpoint, payload1 )
        if int(status_code) == int(expected)  :
            return response
        else:
            raise InvalidExpectedStatus("the expected status code were not equals to the recived one")
    
    
    
    @keyword('DELETE On Session')
    def delete_request(self, endpoint, expected_status_code):
        """Method to send DELETE requests to the specified endpoint
        :param endpoint:  str   Endpoint of service to which the request will be sent
        :return:  the response.
        """
        expected = expected_status_code[len(expected_status_code)-3:]
        
        status_code, response =self.do_request('DELETE', endpoint)
        if int(status_code) == int(expected)  :
            return response
        else:
            raise InvalidExpectedStatus("the expected status code were not equals to the recived one")

    @keyword('Delete All Sessions')
    def delete_all_session(self):
        self.base_url = ""
        self.session.close()
        




