# sephora

Notes:
- The acrhitecture used in this project is based on VIP architecture (it's a personal approach). The data flow is unidirectional: view -> interactor -> presenter -> back to view.
- I kept the UI simple and overall I didn't overdo things. Some could be improved in a real world project but that should be discussed in review.
- I didn't internationalize the application translations. Obviously, any wording would have to be in a constant rather than hard coded like it is.
- I went straight forward regarding the navigation layer. A more suitable direction could be to use coordinators along with factories in a real case scenario.
- Regarding the API, since the exercise required only one service, I didn't implement a full API client.
- I didn't separate models per layer (network, application, ...). In a real world the use of layered models would be prefereable.
- Since the exercise contains a single list, I didn't abstract it. On a large scale application, it could be good to have a generic TableView/CollectionView.
- I handled the minumum required errors. There is room for improvement here.
- I implemented only one example of test. The aim would be to test the whole business logic (interactors, presenters, services) and maybe add some UI Tests.
