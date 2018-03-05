ATM
---------
1. Setup:
    * run `bundle`

2. Usage:
    * `rackup`
    * deposit: 
    ```
    $ curl localhost:9292/api/deposit -H Content-Type:application/json -d "{\"banknotes\":{\"10\":2,\"1\":2}}"    
    "{\"10\":3,\"1\":4}"
    ```
    * withdrawal:
    ```
    $ curl localhost:9292/api/withdrawal -H Content-Type:application/json -d "{\"amount\":11}"
    "{\"10\":1,\"1\":1}" 
    ```
    * status(available banknotes)
    ```
    $ curl localhost:9292/api/status
    "{\"10\":7,\"1\":8}"

    ```

