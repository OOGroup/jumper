# jumper
General Process
---------------
1. As features come up, add them into the [Waffle](https://waffle.io/oogroup/jumper)
2. Be sure to be as descriptive as possible in Waffle. Especially if you aren't the one implementing the feature.
####In Waffle:
3. Press `Add Issue` to create a card for a feature
4. New cards go into `Backlog`, move them to `Ready` when they are fully described. Labels are cool :)
5. When you start work on an issue, assign yourself to the card and move it to `In Progress`
####In command line:
6. `git pull origin master` inside the root directory
7. `git checkout -b <branchname>` to create and checkout a new branch. If you are Paul, it is helpful to name your branches like: `paul-feature-name`
8. And then when you want to push changes: `git push -u origin paul-feature-name` (`-u` first time only)

To do a pull request
--------------------
1. `git push origin paul-feature-name` with the most up-to-date version of your code
####In GitHub:
2. There should be a message about a newly pushed branch and a green button that says something like `Create New Pull Request` If not, check to be sure your push to origin succeeded
3. Change the title of the pull request to something like: `Resolves #18 // Implemented user` with the `#18` coming from the number of the issue (either Waffle card number or on github)
4. Optional (but cool) description
5. Then go down to bottom and hit `Submit Pull Request`
6. Ideally, you check each others' code, but at this point you can also `Merge Pull Request` but beware as any bugs are now in the main code too


Useful Tutorials
----------------
 * http://www.gamefromscratch.com/post/2014/06/03/Game-development-tutorial-Swift-and-SpriteKit-Part-1-A-Simple-iOSMac-OS-App.aspx
 * http://www.raywenderlich.com/84341/create-breakout-game-sprite-kit-swift


Getting Started (New iOS Version)
---------------
  From this directory:
  1. Open the XCode Project
    - `$ open Jumper.xcodeproj`
  2. Attempt to run the app by pressing the play button in the upper left of XCode.
  
**If something goes wrong:**
 * Try going to menu Project > (Hold Alt) > Clean Build Folder...
   - If that doesn't work. Ask Dillon, haha.

Tools
-----
* [Project Organization](https://waffle.io/oogroup/jumper) (Waffle.io)
* [Database](https://www.parse.com/apps/csci4448-project/collections#class/_User) (Parse)
* [Part 2 Google Doc](https://docs.google.com/a/colorado.edu/document/d/13kIsc1WZydRId14s67mdQ8qkwwl6h4DhfGfDytsJlv4/edit?usp=sharing) (Google Doc containing initial, first-draft Project Specs, Diagrams and UI Mocks)
* [Lucidchart Project Folder](https://www.lucidchart.com/documents#docs?folder_id=107160918&browser=icon&sort=saved-desc) (Folder containing UML Diagrams of the project)
* [Project Description](https://moodle.cs.colorado.edu/pluginfile.php/23276/mod_resource/content/0/Project-4448.pdf) PDF from Liz

Collaborators
-------------
  * Hope Sanford (hosa2511@colorado.edu)
  * Jenna Raderstrong (jenraders@gmail.com)
  * Robert Crimi (rocr5180@colorado.edu)
  * Sam Beckett (sabe3525@colorado.edu)
  * Dillon Drenzek (dr.enzek@gmail.com)
