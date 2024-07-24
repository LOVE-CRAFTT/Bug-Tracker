# Bug Tracker
This is a bug tracking application developed using Flutter, built for windows for my final year project. The application enables development teams to receive bug reports from customers, assign tasks to staff for resolution, and monitor progress. Customers can also track the progress and solution plans of these reports, leading to a more transparent system.

Insipred by Zoho bug tracker application [https://www.zoho.com/bugtracker/].

## Features
- Report and track bugs
- Assign tasks to team members for bug resolution
- Monitor progress of bug resolution
- Customers can track progress and solution plans
- Staff-staff messaging
- Calendar including adding activities
- Work session tracking
- Automatic progression e.g. when a complaint is opened by the admin the state is changed from pending to acknowledged automatically.

## UI samples
Note: not an exhaustive list of the entire UI

|                          |                          |
|--------------------------|--------------------------|
![](./readme-files/signInPage.png)  |  ![](./readme-files/signUpPage.png)
> sign in  and sign up pages

<br>

![](./readme-files/userDashboard.png)
> User's dashboard

<br>

![](./readme-files/userSubmitComplaintForm.png)
> User's complaint submission form

<br>

![](./readme-files/complaintDetail.png)
> User's complaint detail page (after clicking on a complaint)

<br>

![](./readme-files/adminHomePage.png)
> Admin home page

<br>

|                          |                          |
|--------------------------|--------------------------|
![](./readme-files/adminBugOverview1.png)  |  ![](./readme-files/adminBugOverview2.png)
> Admin's bugs overview

<br>

![](./readme-files/adminProjectsOverview.png)
> Admin's projects overview

<br>

|                          |                          |
|--------------------------|--------------------------|
![](./readme-files/projectDetail1.png)  |  ![](./readme-files/projectDetail2.png)
> Project details (after clicking a project)

<br>

![](./readme-files/adminOrStaffTaskPage.png)
> Tasks page (Same format for admin and staff)

<br>

![](./readme-files/staffPage.png)
> Staff page

<br>

![](./readme-files/staffDetailUpdate.png)
> View staff information and ability to modify some data

<br>

![](./readme-files/calenda.png)
> Inbuilt calendar with ability to add activities

<br>

|                          |                          |
|--------------------------|--------------------------|
![](./readme-files/trasnfertask1.png)  |  ![](./readme-files/transferTask2.png) 
> Transfer task ability

<br>

|                          |                          |
|--------------------------|--------------------------|
![](./readme-files/discussions.png)  |  ![](./readme-files/messages.png) 
> Inbuilt chat feature

<br>

![](./readme-files/time%20tracking.png)
> Time tracking feature

<br>

|                          |                          |
|--------------------------|--------------------------|
![](./readme-files/sessionLog1.png) |  ![](./readme-files/sessionLog2.png) 
> View (time tracked) sessions log

## Comments
- Pretty well commented codebase
- Doesn't work on web due to mysql1 package using sockets which flutter web doesnt support
- Plan to add a generate payment invoice feature based on hourly pay

## Setup
1. Install Flutter on your machine.
2. Clone this repository.
3. Run `flutter pub get` to install the necessary packages.
4. Create MySQL database with the sql file and modify credentials in db.dart file
5. Run `flutter run` to start the application.
6. Select Windows as the build choice
