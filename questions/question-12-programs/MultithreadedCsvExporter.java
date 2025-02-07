import java.sql.*;
import java.io.*;
import java.util.*;
import java.util.concurrent.*;

public class MultithreadedCsvExporter {

    // Function to write CSV for each location
    public static void writeCsvForLocation(String location, List<String[]> data) {
        String fileName = location + "_inventory.csv";
        
        // Writing the data to CSV using BufferedWriter for better performance
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {
            // Write header
            writer.write("Item ID,Department,Unit Cost,Stock On Hand,Stock Value");
            writer.newLine();
            
            // Write data rows
            for (String[] row : data) {
                writer.write(String.join(",", row));
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Function to fetch and process the data in batches and create the CSV files
    public static void processBatch(Connection conn, ExecutorService executor) throws SQLException {
        String sql = "SELECT item_id, department, unit_cost, stock_on_hand, stock_value, location FROM inventory_table";
        int batchSize = 100000;  // Process 100,000 records at a time
        int offset = 0;
        
        while (true) {
            // Fetching data in batches
            String batchSql = sql + " OFFSET " + offset + " ROWS FETCH NEXT " + batchSize + " ROWS ONLY";
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(batchSql)) {
                Map<String, List<String[]>> locationData = new HashMap<>();
                
                // Process the result set
                while (rs.next()) {
                    String location = rs.getString("location");
                    String itemId = rs.getString("item_id");
                    String department = rs.getString("department");
                    double unitCost = rs.getDouble("unit_cost");
                    int stockOnHand = rs.getInt("stock_on_hand");
                    double stockValue = rs.getDouble("stock_value");

                    // Store the data by location
                    locationData.computeIfAbsent(location, k -> new ArrayList<>())
                                .add(new String[]{itemId, department, String.valueOf(unitCost), 
                                                  String.valueOf(stockOnHand), String.valueOf(stockValue)});
                }

                // Submit tasks to the executor for each location
                for (Map.Entry<String, List<String[]>> entry : locationData.entrySet()) {
                    final String location = entry.getKey();
                    final List<String[]> data = entry.getValue();
                    executor.submit(() -> writeCsvForLocation(location, data));
                }

                // If fewer records than batch size, we are done
                if (locationData.size() < batchSize) {
                    break;
                }
                offset += batchSize;  // Move to the next batch
            }
        }
    }

    public static void main(String[] args) {
        String dbUrl = "jdbc:oracle:thin:@yourdbhost:port:sid";  // Update with your DB credentials
        String dbUser = "your_user";
        String dbPassword = "your_password";

        // Start the timer
        long startTime = System.currentTimeMillis();

        // Establish database connection
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
            // Create an ExecutorService with a fixed thread pool for parallel processing
            int numberOfThreads = 10; // Adjust this based on your CPU cores
            ExecutorService executor = Executors.newFixedThreadPool(numberOfThreads);

            // Process data in batches and generate CSV files
            processBatch(conn, executor);

            // Shutdown the executor service after all tasks are submitted
            executor.shutdown();
            while (!executor.isTerminated()) {
                // Wait for all threads to finish
            }

            // End the timer
            long endTime = System.currentTimeMillis();
            System.out.println("Time taken to create the files: " + (endTime - startTime) + " milliseconds");

        } catch (SQLException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
