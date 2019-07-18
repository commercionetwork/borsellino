# Borsellino
This project contains the Flutter version of Borsellino, the [Commercio.network](https://commercio.network)'s 
official wallet.  

## Developing
Following you will find some tips on how to easily develop your custom version of Borsellino.

### BLoC
The whole project is based on the [BLoC Library](https://felangel.github.io/bloc/#/).  
Using it we can ensure separation of concerns between the logic and the presentation part. BLoC are all found inside 
the `lib/bloc` folder and all act as a middle layer between the logic part and the view part, representing the 
presentation layer themselves. 

We tried to follow the [architecture idea](https://felangel.github.io/bloc/#/architecture) that is described on the 
BLoC library page. This means we have the following code dependencies:

```
Page -> BLoC -> Repository -> Source
``` 

And the following data flow:
```
Page -> BLoC -> Repository -> Source 
                                |
                 Data is fetched from internet,
                 saved on the device or manipulated
                                |
                                V
Page <- BLoC <- Repository <- Source
```

### Dependency injection
In order to prevent having a lot of dependencies into the `main` function, we used the 
[dependency injection pattern](https://en.wikipedia.org/wiki/Dependency_injection).  
In order to do so, we used the [dependencies_flutter Dart library](https://pub.dev/packages/dependencies_flutter) 
following the [Medium article](https://medium.com/@marcguilera/dependency-injection-in-flutter-625650195a98) 
made by its creator. 

We've put all the modules that provide the different components into the `lib/dependency_injection` folder.  
The main class that acts as a singleton to get the dependencies is located into the `injector.dart` file. 

That class is used inside the BLoC implementations in order to get a reference to the repositories that each one
uses to fetch or save the data.