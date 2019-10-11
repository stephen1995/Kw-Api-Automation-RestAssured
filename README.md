# api-automation-contacts-module
Contacts services automation

Pre condition:
 - Clone the repository: 
     https://github.com/KWRI/api-automation-contacts-module
 - Open the project in any IDE. 
     Example: Eclipse

Eclipse setup:
 - Click right on the Project
 - Go to Properties
 - Go to Java Build Path 
 - Select JRE: jdk 1.8
 - Apply
 - Go to Java Compiler 
 - Select compiler compliance level (jdk 1.8)
 - Aply and close

Project setup:
 - Click right on the Project
 - Go to Maven 
 - Go to update project 
 - Select Force Update of Snapshot/Release
 - Select Ok

Execute project:
 - Click right on the Project 
 - Go to Run As 
 - Select Maven install

Note:
- You can select the feature that should be execute adding the tag that configures in the java file: RunCukesTest.java
For example:
       tags = "@testing"
