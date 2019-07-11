#  Accessing different files inside the repository:

1. The ruby files related to the models are in "lib" folder.

2. The test files are in the "spec" folder.

3. The required file for running the server is "server.rb" file.

4. I have used Sinatra framework for building the API.

5. I have used Rspec as the testing framework.

# How to install and start the server

1. At first you can clone or fork the repository from [here](https://github.com/soroushh/Tails)!

2.  Make sure you have Ruby installed on your machine, then you need to install "bundler" gem on your machine using the following command:

``` gem install bundler ```

3. Once you installed "bundler", use it to install the dependencies (gems) by running the following command:

``` bundle install ```

4. After installing all dependencies, you can run the server by running the following command on your terminal:

``` ruby server.rb ```

Now you have access to your server in the following url using your browser.

http://localhost:4567

After starting the server, you can make POST requests to the server and receive the response in "json" format.

## Proper requests to the API and the received response

As you see in the server.rb file, there are two versions of "v1" and "v2" API.

### v1 API

This version of API receives POST requests with json body.
After starting the server, you can send a POST request to the following url using Postman, as shown in the following image.
``` http://localhost:4567/api/v1/orders ```
<img src="./images/v1Request.png" />

The response of the API will be in json format as you see in the image below. An important property of this response is that the all the prices and VATs are rounded to the nearest penny, which is the chosen unit here.
<img src="./images/v1Respond.png" />
The above response gives the total price and total VAT of the chosen products for that order together with the break down of the price and VAT of each individual product.

### v2 API

This version of API is an extended version of v1. In this version you will choose the "currency" in your request, therefore, the prices and VATs in the response will be given in the chosen currency with the accuracy of 0.01.

 The correct POST request format is shown in the following image. As you can see, the "currency" is added to the body of your request, where you need to enter the currency code of your choice, e.g. "USD" means $. In order to get the a list of currency codes, you can have a look at [https://free.currencyconverterapi.com](https://www.currencyconverterapi.com/docs).

In order to use v2 version of API, after starting the server, you can send a POST request to the following url.
``` http://localhost:4567/api/v2/orders ```

I used Postman to send the POST request, for which you can see the correct body format in the following image.

<img src="./images/v2Request.png" />

The response will be in json format where all the prices and VATs have an accuracy of 0.01 with the unit of the currency you entered in the request.

<img src="./images/v2Response.png" />

## Tests

I have used Rspec framework to test the pricing logic for the problem. The test files are inside the "spec" folder. to run the tests, you can run the following command in the terminal:

``` rspec ```

## If I had more time

At the moment, I have written the unit tests for all of my models, covering pricing logic. If I had more time, I would try to add some tests for the API itself.

To test the API, first I ran the server from which I sent some POST requests with the correct body to the server using Postman. Then I checked the response from that API call to make sure it has the correct format, and shows the total_price, total_VAT and the break down of the price and VAT for each product. This testing process can be automated; if I had more time, I would try to search a some more to find the correct way of testing the API automatically.

If I had more time, I would also work on the error handling; so if a request with incorrect format or invalid body is sent, correct error responses are shown.

## What I am proud of
I have worked with APIs before but I haven't built one from scratch until completing this task. I am proud of writing this API for the first time on my own, which is capable of receiving a POST request in json and sending a json response back. This proves that I am capable of learning and applying new concepts on my own.


## The Toughest bits

To design the pricing logic I made four classes (models), which were accessed in both my API versions. In order to make an object for each class, I had to have access to the request body, as a result of which I had to use request body four times. In my initial design I was not able to do this but after some research online I found that by using the following code I can fix this issue.

 ```before do``` </br>
    &nbsp; &nbsp; ```request.body.rewind``` </br>
    &nbsp; &nbsp;   ```@request_payload = JSON.parse request.body.read``` </br>
    ``` end ```

Once "@request_payload" was defined, I used it in my server file to gain access to the request body more than one time.



## Why only one endpoint ???

As you see in my server.rb file, I have only used one endpoint for both v1 and v2 APIs. The reason for this choice is that here I was writing the API for a small number of products which would be only used for this test. If I were to design an API for a large company with many products and customers, who would use the API many times, the design would be different. In this case I would design more endpoints so the users only get the specific information they need such as total price. This would mean that the responses are not crowded by unnecessary information, which in turn leads to reduction in data storage and management costs.


 ## How to make the test more clear and better
 There is nothing that specifies what is the required accuracy for showing the prices and VATs in foreign currencies like USD. Is the accuracy 1 (dollar) or 0.01 (cent) in the response price and VAT ? It would be better to specify the required accuracy in the test description.
 At the moment, there are only three requirements for the endpoint, i.e.
 - total price for the order</br>
 -  total VAT for the order</br>
 - price and VAT for each item in the order </br>

 , whereas, I believe currency should also be added to these requirements so when the user makes a use of this API, they know what currency the total cost is in. An example response with the currency requirement is shown in the image below.
<img src="./images/v2ComResponse.png" />
