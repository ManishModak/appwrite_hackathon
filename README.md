# MAT SECURITY: [Appwrite](https://appwrite.io) [Hashnode](https://hashnode.com) Hackathon

### An Flutter Application developed for Schools and Colleges to track daily in out registry of students.


## Team Details

- MANISH MODAK - @xManish
- AMAN MUNJEWAR - @AmanMunjewar
- ABHISHEK FADAKE - @fadkeabhi

## Description of Project

MAT SECURITY is an easy to use mobile app that revolutionizes hostel security management. With its seamless interface, it allows security guards to efficiently track the entry and exit of students. The app enables the creation and management of student profiles, offers comprehensive views of student details, and provides daily logs for monitoring activities. Additionally, MAT SECURITY highlights students who haven't returned, ensuring enhanced safety and accountability in hostel environments. Experience a new level of security with MAT SECURITY.

MAT SECURITY is a professionally developed mobile application built using the Flutter framework and powered by the Appwrite cloud backend. Leveraging the versatility of Flutter, the app offers a seamless and responsive user interface across both iOS and Android platforms. With Appwrite Cloud, the app benefits from secure and scalable backend services, including authentication, database management, real-time updates, and file storage. By combining the power of Flutter and the reliability of Appwrite Cloud, MAT SECURITY delivers a robust and efficient solution for hostel security management.

## Tech Stack

- Flutter
- Appwrite Cloud
    - Authentication
    - Database
    - Storage
    - Cloud Functions - Node.js

In this project almost all of the appwrite services are used.

1. Authentication : Appwrites Authentication service simplified the user managment process. Also Teams and membership feature helped to manage the admins of Application in simple and easy way.
2. Database : We used Appwrites Database service to store the students information and daily log.
3. Storage : Appwrite storage is used used in this app to store the photo of an student on cloud. Also the old logs are being stored in storage to reduce the database load and boost overall efficiency of the app.
4. Cloud Functions : We have also used the Cloud Functions from the Appwrite to implement some server side tasks. Currently We are using 2 cloud functions. Both are implemented in Node.js. One of the function is used to add new email as an admin. In this function email is added in team called as Admin which have all the admin previleges. Another function is used to move all old logs from the database to an file in bucket storage. All necessary conditions are checked before file transfer. like check if all students entry are complete, etc. This function is set on an cron job.



## Challenges We Faced

1. Database Structure: 

    As we knew Appwrite didn't provide a direct subdocument feature, which makes categorizing documents challenging.
    - Solution: We took leverage of the Query feature to filter out the required documents, reducing network load.
    - Remark: The Query feature is valuable as it allows us to fetch specific data without downloading the entire document set.

2. Manual Creation of Database and Collection:

    Unlike Firebase Firestore, where a database is created automatically if referenced, Appwrite requires manual creation of databases and collections.
    - Solution: We have modified our database structure to utilize a single database per organization and a single collection for each data set.
    - Remark: With the Query feature, we can avoid the need for multiple collections, simplifying our database structure.
    Also this restriction helped us to keep all documents well formatted.

3. Create Team Membership :

    From frontend sdk it was difficult to add a membership to a team. It is multistep process. Also it involves sending an email to user about joining. 
    - Solution: To add membership we decided to shift to backend. We selected the Appwrite functions to execute the server code. We used the Node.js SDK for the same.
    - Remark: By leveraging the power of appwrite function we also created a Node.js code to move all previous log records to a bucket file.



## Public Code Repo

https://github.com/ManishModak/Appwrite-Hackathon

## Demo Link

