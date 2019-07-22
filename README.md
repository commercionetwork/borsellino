# Borsellino
Borsellino is the first multi-chain, easy-to-use and multiplatform Cosmos Hub wallet. 
Entirely made with [Flutter](https://flutter.dev/), it fetches the data about the supported chains 
from a remote source. This means that adding a new supported chain is no harder than submitting a PR to the proper 
[GitHub repository](https://github.com/RiccardoM/CosmosHub-Chains) 😉.

## Supported chains
Currently supported chains are: 

| Project | Chains versions | Repository | 
| :------ | :-------------: | :--------- |
| Bitsong.io | `bitsong-testnet-1` | https://github.com/bitsongofficial/go-bitsong |
| Commercio.network | `commercio-testnet1001` | https://github.com/commercionetwork/commercionetwork |
| Cosmos Mainnet | `cosmos-hub2` | https://github.com/cosmos/cosmos-sdk | 
| Kava | `kava-testnet-1.1` | https://github.com/Kava-Labs/kava |
| Regen.network | `regent-test-1001` | https://github.com/regen-network/regen-ledger | 

## Running
In order to run the this project you must satisfy the given pre-requisites:
 
- Having [Flutter](https://flutter.dev/) installed.  
   In order to install it, you can follow the [official documentation](https://flutter.dev/docs/get-started/install).

- Having an Android or iOS emulator setup (alternatively, an Android or iOS physical device connected to your pc). 

**Note**. For Android-based systems, the application will only work on devices running Android Lollipop (API 21) or later. 

### Setup
**1**. Switch to the master branch of Flutter by running:
```bash
flutter channel master 
flutter upgrade
``` 

**2.**. Download all the project dependencies by running: 
```bash
flutter pub get
```

**3.** Complete the setup by running
```bash
flutter pub run build_runner build
```

**4.** Run the project: 
```bash
flutter run 
```



## Project architecture

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