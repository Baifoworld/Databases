# 🏋️ Fitness Club SQL Database

This project contains a structured **MySQL** database for managing the operations of a fitness club. It includes entities like clients, monitors (trainers), workout rooms, attendance tracking, video logs (vlogs), and messaging between users.

## 📦 Project Structure

The main file in this repository is:

- `fitness_club.sql` — SQL script to create the full database schema and insert example data.

## 🔍 Key Features

- **User Management**: Stores all user credentials and roles (client or monitor).
- **Client & Monitor Profiles**: Holds personal, contact, and physical data.
- **Room & Assignment Tracking**: Maps monitors to workout rooms and tracks room capacities.
- **Workout Vlogs**: Lets monitors upload multi-step workout videos with instructions.
- **Client Monitoring**: Assigns monitors to clients and logs progress reports.
- **Attendance System**: Tracks daily attendance for clients.
- **Messaging System**: Allows communication between clients and their monitors.

## 🛠️ How to Use

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/fitness-club-database.git
   cd fitness-club-database
   ```

2. **Set up the database in MySQL**

   - Open MySQL Workbench, phpMyAdmin, or your preferred SQL tool.
   - Create a new database:
     ```sql
     CREATE DATABASE fitness_club;
     ```
   - Select the database:
     ```sql
     USE fitness_club;
     ```
   - Run the SQL script:
     ```sql
     SOURCE fitness_club.sql;
     ```

3. **Explore the data**
   Run queries to explore relationships or simulate app functionalities.

## 💡 Example Queries

```sql
-- Get clients and their assigned monitors
SELECT u.username AS client_username, m.specialty
FROM clients c
JOIN users u ON c.user_id = u.id
JOIN client_monitor_assignments a ON c.id = a.client_id
JOIN monitors m ON a.monitor_id = m.id;

-- Get vlog steps for a monitor
SELECT v.title, vc.step_number, vc.content
FROM vlogs v
JOIN vlog_content vc ON v.id = vc.vlog_id
WHERE v.monitor_id = 1;
```

## 🗃️ Tables Overview

| Table                        | Description                                     |
| ---------------------------- | ----------------------------------------------- |
| `users`                      | Basic user credentials and role info            |
| `clients`                    | Client-specific data including physical metrics |
| `monitors`                   | Trainer info including experience and specialty |
| `rooms`                      | Workout room info and capacity                  |
| `monitor_rooms`              | Assigns monitors to rooms                       |
| `monitor_specializations`    | Tracks each monitor's specialties               |
| `vlogs`                      | Video workouts uploaded by monitors             |
| `vlog_content`               | Step-by-step details of each vlog               |
| `client_monitor_assignments` | Tracks which monitor is assigned to each client |
| `reports`                    | Progress reports submitted by monitors          |
| `assistances`                | Attendance records                              |
| `messages`                   | Direct messages between users                   |

## 📄 License

This project is open source and licensed under the [MIT License](LICENSE).

---

### 📬 Contributing

Pull requests are welcome! If you’d like to add features or fix bugs, feel free to fork the repo and submit a PR.

---

Enjoy building with SQL! 💪
