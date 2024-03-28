CREATE DATABASE IF NOT EXISTS bug_tracker;
USE bug_tracker;

CREATE TABLE IF NOT EXISTS staff (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_admin BOOLEAN NOT NULL,
    surname VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    middle_name VARCHAR(255)
) AUTO_INCREMENT=10000;

CREATE TABLE IF NOT EXISTS user (
    email VARCHAR(255) NOT NULL PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    middle_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS project (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    details MEDIUMTEXT,
    project_state ENUM('Cancelled', 'Closed', 'Open', 'Postponed') NOT NULL,
    date_created DATETIME NOT NULL,
    date_closed DATETIME
) AUTO_INCREMENT=10000;

CREATE TABLE IF NOT EXISTS complaint (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    notes MEDIUMTEXT,
    associated_project INT UNSIGNED NOT NULL,
    author VARCHAR(255) NOT NULL,
    date_created DATETIME NOT NULL,
    complaint_state ENUM('Acknowledged', 'Completed', 'In Progress', 'Pending') NOT NULL,
    tags ENUM('Database', 'Functionality', 'Network', 'Performance', 'Security', 'UI'),
    FOREIGN KEY (associated_project) REFERENCES project(id)
) AUTO_INCREMENT=10000;

CREATE TABLE IF NOT EXISTS task (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    associated_complaint INT UNSIGNED NOT NULL,
    task_name VARCHAR(255) NOT NULL,
    task_state ENUM('Completed', 'Due Today', 'In Progress', 'New', 'Overdue', 'Updated') NOT NULL,
    due_date DATETIME NOT NULL,
    associated_staff INT UNSIGNED NOT NULL,
    is_team_lead BOOLEAN NOT NULL,
    FOREIGN KEY (associated_complaint) REFERENCES complaint(id),
    FOREIGN KEY (associated_staff) REFERENCES staff(id)
) AUTO_INCREMENT=10000;

CREATE TABLE IF NOT EXISTS files (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    file_name VARCHAR(255),
    file_path TEXT NOT NULL,
    associated_complaint INT UNSIGNED NOT NULL,
    FOREIGN KEY (associated_complaint) REFERENCES complaint(id)
);

CREATE TABLE IF NOT EXISTS staff_note (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    note TEXT NOT NULL,
    associated_complaint INT UNSIGNED NOT NULL,
    FOREIGN KEY (associated_complaint) REFERENCES complaint(id)
);

CREATE TABLE IF NOT EXISTS calendar_events (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    associated_staff INT UNSIGNED NOT NULL,
    date DATETIME NOT NULL,
    event_title VARCHAR(255) NOT NULL,
    FOREIGN KEY (associated_staff) REFERENCES staff(id)
);

CREATE TABLE IF NOT EXISTS conversations (
    conversation_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS conversation_participants (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    conversation_id INT UNSIGNED NOT NULL,
    staff_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id),
    FOREIGN KEY (staff_id) REFERENCES staff(id)
);

CREATE TABLE IF NOT EXISTS messages (
    message_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    conversation_id INT UNSIGNED NOT NULL,
    staff_id INT UNSIGNED NOT NULL,
    message TEXT NOT NULL,
    time_created DATETIME NOT NULL,
    FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id),
    FOREIGN KEY (staff_id) REFERENCES staff(id)
);
