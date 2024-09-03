**FRAMEWORK:**
/nThis Project build by SwiftUI for the UI Framework. SwiftUI is the lates framework for develop apple platform with one codebase(e.g. MacOS, iPadOS and iOS).

**HOW TO RUNNING:**
1. Download XCode
2. Open the project on XCode
3. Cmd + B to build the project first to check it succeed or showing any errors
4. Select the target simulator or real device on the top bar of XCode
5. Click play button to run the project to the simulator/real device

**ARCHITECTURE:**
\nThis Project using MVVM (Model View ViewModel) for the arch./n
<img width="456" alt="image" src="https://github.com/user-attachments/assets/c2f94ac3-abfc-4e0d-a516-cfab6e5edf98">
- View will be represented by SwiftUI View that will accepts data change from ViewModel to update the UI and able to send action to the ViewModel
- ViewModel will be ObservableObject that accepts action from SwiftUI View and execute to business logic process
- Model will be the the structure for the data from network
