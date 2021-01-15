# MovieSampleApp
Sample Movie App with Repository UseCase Infrastructure and MVV-C Design Pattern

![Language](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg)

`MovieSampleApp` projesi storyboard kullanılmadan programatik layout constraintler ile yazıldı. Layoutları daha düzenli yönetmek için constraintler için DSL extension yazıldı.  
`MovieSampleApp` MVVM-C design patterni üzerine kurulu. Coordinator, ViewController ve ViewModeli oluşturur, ilgili dependencyleri inject eder ve retain cycle oluşturmayacak şekilde hiyerarşiyi yönetir.
Coordinatorlar parent child ilişkisi ile ilerler ve ViewControllerlar arası geçişte tüm rootingi Coordinator yönetir. Dismiss aksiyonlari ViewModele -> Coordinator şeklinde iletilir. Proje içerisinde PresentationLayer dizini altında ilgili modüllere ait MVVM-C dosyaları yer alır.

## Welcome to MovieSampleApp

- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [URENCombine](#urencombine)
  - [URENCore](#urencore)
  - [URENCoreData](#urencoredata)
  - [URENData](#urendata)
  - [URENDomain](#urendomain)
  - [MovieSampleApp](#moviesampleapp)
     - [Data](#data)
     - [Domain](#domain)
     - [Presentation](#presentation)

## Getting Started

`MovieSampleApp` mimarisi Domain, Data ve Presentation katmanlarından oluşmakta. Design pattern olarak ise MVVM-C kullanılmakta. Proje 5 tane embedded frameworkten içerir. `MovieSampleApp` projesi storyboard kullanılmadan programatik layout constraintler ile yazıldı. Layoutları daha düzenli yönetmek için constraintler için DSL extension yazıldı.  
`MovieSampleApp` MVVM-C design patterni üzerine kurulu. Coordinator, ViewController ve ViewModeli oluşturur, ilgili dependencyleri inject eder ve retain cycle oluşturmayacak şekilde hiyerarşiyi yönetir.
Coordinatorlar parent child ilişkisi ile ilerler ve ViewControllerlar arası geçişte tüm rootingi Coordinator yönetir. Dismiss aksiyonlari ViewModele -> Coordinator şeklinde iletilir. Proje içerisinde PresentationLayer dizini altında ilgili modüllere ait MVVM-C dosyaları yer alır.

### Requirements

- Swift 5.0 (Xcode 10.2)

### URENCombine

ios 13 ile gelen Combine baz alarak yazdığım bir kaç combine özelliğini içeren reactive programming. iOS 10 ve üstünü destekliyor. Hiçbir framework bağımlılığı yok.

### URENCore

ImageCache ve URENImageView içeriyor. iOS 10 ve üstünü destekliyor. Hiçbir framework bağımlılığı yok.

### URENDomain

Domain modellerini, use caseleri ve request response modelleri, repository patterna ait protocolü bulunduran framework. iOS 10 ve üstünü destekliyor. `URENCombine` frameworkünü kullanır.

### URENData

Repository protocolüne ait implementasyonu ve network katmanını içerir. iOS 12 ve üstünü destekliyor. `URENCombine` ve `URENDomain` frameworklerini kullanır.

### URENCoreData

Local repository protocolünü ve implementasyonunu içerir. Repository  iOS 10 ve üstünü destekliyor. `URENCore` ve `URENDomain` frameworklerini kullanır.

### MovieSampleApp

#### Data

Repository implementasyonu ve Network katmanını içerir.

#### Domain

Repository Protocol, UseCase ve Domain Modelleri içerir.

#### Presentation

- Presentation katmanı uygulamanın kendisinde yer alır ve MVVM-C design pattern kullanılmaktadır. 
- Coordinator ilgili ViewController ve ViewModeli oluşturur ve ihtiyaç duyulan configürasyonları inject eder. 
- Coordinator aynı zamanda ViewModeli dinler ve gelen rooting isteklerini ilgili child Coordinatorlere iletir.
- ViewController, ViewModel ile haberleşerek tüm business akışlarını ViewModel ile haberleşir.
- ViewModel ilgili UseCase üzerinden birim işi yapan servisi çağırır ve akışı dinler.
- CoreData yönetiminde dataların view üzerinde gösterilmesi için ViewModel, NSFetchedResultsController ile haberleşerek değişiklikleri anlık publish eder.
- Dil desteği içermektedir.
- UI design da component yaklaşımı benimsenmiştir.

## License

`MovieSampleApp` is not released any license yet.
