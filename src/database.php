<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <title>Database Interface</title>
      <style type="text/css">
         body {
            font-family: sans-serif;
            background-color: lightyellow;
         }
         table {
            background-color: lightblue;
            border-collapse: collapse;
            border: 1px solid gray;
            width: 100%;
         }
         td, th {
            padding: 10px;
            text-align: left;
            border: 1px solid gray;
         }
         tr:nth-child(odd) {
            background-color: white;
         }
         h2 {
            color: darkblue;
         }
         form {
            margin-bottom: 20px;
         }
         label {
            font-weight: bold;
         }
      </style>
   </head>
   <body>
      <h1>Real Estate Listings Database</h1>
      <?php
         $database = mysqli_connect("localhost", "root", "", "rproducts");

         if (!$database) {
            die("<p>Could not connect to database: " . mysqli_connect_error() . "</p>");
         }

         // Function to execute a query and display results in a table
         function displayQueryResults($query, $database) {
            $result = mysqli_query($database, $query);

            if (!$result) {
               echo "<p>Query failed: " . mysqli_error($database) . "</p>";
               return;
            }

            if (mysqli_num_rows($result) > 0) {
               echo "<table><tr>";
               // Print table headers
               while ($field = mysqli_fetch_field($result)) {
                  echo "<th>{$field->name}</th>";
               }
               echo "</tr>";
               // Print table rows
               while ($row = mysqli_fetch_assoc($result)) {
                  echo "<tr>";
                  foreach ($row as $value) {
                     echo "<td>$value</td>";
                  }
                  echo "</tr>";
               }
               echo "</table>";
            } else {
               echo "<p>No results found.</p>";
            }
         }

         if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            if (isset($_POST['query'])) {
               $customQuery = $_POST['query'];
               echo "<h2>Custom Query Results</h2>";
               displayQueryResults($customQuery, $database);
            } elseif (isset($_POST['action'])) {
               switch ($_POST['action']) {
                  case 'listings':
                     echo "<h2>All Listings</h2>";
                     displayQueryResults("SELECT * FROM Listings", $database);
                     break;
                  case 'houses':
                     echo "<h2>All Houses</h2>";
                     displayQueryResults("SELECT * FROM House", $database);
                     break;
                  case 'business_properties':
                     echo "<h2>All Business Properties</h2>";
                     displayQueryResults("SELECT * FROM BusinessProperty", $database);
                     break;
                  case 'agents':
                     echo "<h2>All Agents</h2>";
                     displayQueryResults("SELECT Agent.AgentID, Agent.name, Agent.phone, Firm.name AS FirmName, Agent.dateStarted FROM Agent JOIN Firm ON Agent.firmID = Firm.id", $database);
                     break;
                  case 'buyers':
                     echo "<h2>All Buyers</h2>";
                     displayQueryResults("SELECT * FROM Buyer", $database);
                     break;
                  case 'search_houses':
                     $minPrice = $_POST['min_price'];
                     $maxPrice = $_POST['max_price'];
                     $bedrooms = $_POST['bedrooms'];
                     $bathrooms = $_POST['bathrooms'];
                     $query = "SELECT * FROM House NATURAL JOIN Property WHERE price BETWEEN $minPrice AND $maxPrice AND bedrooms = $bedrooms AND bathrooms = $bathrooms ORDER BY price DESC";
                     echo "<h2>Search Results for Houses</h2>";
                     displayQueryResults($query, $database);
                     break;
                  case 'search_business_properties':
                     $minPrice = $_POST['min_price'];
                     $maxPrice = $_POST['max_price'];
                     $minSize = $_POST['min_size'];
                     $maxSize = $_POST['max_size'];
                     $query = "SELECT * FROM BusinessProperty NATURAL JOIN Property WHERE price BETWEEN $minPrice AND $maxPrice AND size BETWEEN $minSize AND $maxSize ORDER BY price DESC";
                     echo "<h2>Search Results for Business Properties</h2>";
                     displayQueryResults($query, $database);
                     break;
               }
            }
         }
         mysqli_close($database);
      ?>

      <h2>Options</h2>
      <form method="POST">
         <label>Choose an Action:</label>
         <select name="action">
            <option value="listings">View All Listings</option>
            <option value="houses">View All Houses</option>
            <option value="business_properties">View All Business Properties</option>
            <option value="agents">View All Agents</option>
            <option value="buyers">View All Buyers</option>
         </select>
         <button type="submit">Submit</button>
      </form>

      <h2>Search Houses</h2>
      <form method="POST">
         <input type="hidden" name="action" value="search_houses">
         <label>Minimum Price:</label> <input type="number" name="min_price" required><br>
         <label>Maximum Price:</label> <input type="number" name="max_price" required><br>
         <label>Bedrooms:</label> <input type="number" name="bedrooms" required><br>
         <label>Bathrooms:</label> <input type="number" name="bathrooms" required><br>
         <button type="submit">Search</button>
      </form>

      <h2>Search Business Properties</h2>
      <form method="POST">
         <input type="hidden" name="action" value="search_business_properties">
         <label>Minimum Price:</label> <input type="number" name="min_price" required><br>
         <label>Maximum Price:</label> <input type="number" name="max_price" required><br>
         <label>Minimum Size (sq ft):</label> <input type="number" name="min_size" required><br>
         <label>Maximum Size (sq ft):</label> <input type="number" name="max_size" required><br>
         <button type="submit">Search</button>
      </form>

      <h2>Custom Query</h2>
      <form method="POST">
         <label>Enter Query:</label> <input type="text" name="query" size="80" required><br>
         <button type="submit">Run Query</button>
      </form>
   </body>
</html>
