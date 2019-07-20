# Borsellino
Borsellino is the first multi-chain, easy-to-use and multiplatform Cosmos Hub wallet. 
Entirely made with [Flutter](https://flutter.dev/), it fetches the data about the supported chains 
from a remote source. This means that adding a new supported chain is no harder than submitting a PR to the proper 
[GitHub repository](https://github.com/RiccardoM/CosmosHub-Chains) 😉.

## Supported chains
Currently supported chains are: 
* [Bitsong.io Testnet](https://github.com/bitsongofficial/go-bitsong)
* [Commercio.network Testnet](https://github.com/commercionetwork/commercionetwork)
* [Cosmos Mainnet](https://github.com/cosmos/cosmos-sdk)
* [Kava Testnet](https://github.com/Kava-Labs/kava)
* [Regen.network Testnet](https://github.com/regen-network/regen-ledger)

## Developing
Following you will find some tips on how to easily develop your custom version of Borsellino.

### Setup
First thing first, run the following command:
```bash
flutter pub run build_runner build
```

This will ensure that the proper JSON converter are generated successfully and you don't run 
into issues at a later time. 

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