Museochoix
==========

Ce projet a été développé dans le cadre de l'événement Museomix Léman 2014 au musée d'Art et d'histoire de Genève, Suisse.

Il a pour but de démontrer une nouvelle manière de visiter un musée: visite à la carte selon ses envies.

A travers un parcours dynamique et personnalisé, le visiteur se voit présenter différentes informations sous différentes formes, par rapport aux envies qu'il a sélectionné.

Plus d'infos et de détails sur http://www.museomix.org/prototypes/museochoix/


Installation
------------

L'application Muséochoix a été compilée pour être installée sur l'iPad 2 mis à disposition durant l'événement Muséomix. Il ne peut être installé que sur cet iPad (voir exception ci-dessous).

Afin d'installer l'application:

1. Connecter l'iPad à un ordinateur ayant iTunes installé.
2. Glisser - Déposer le fichier Museochoix.ipa qui se trouve sur ce compte Github sur l'icône iTunes
3. Aller dans les préférences de l'iPad dans iTunes et faites en sorte que l'application Museochoix soit installée lors de la synchronisation.

A noter que l'application peut en théorie être re-signée afin d'être installée sur d'autres iPad en ayant un compte Apple Developer à disposition et en suivant cette procédure: https://coderwall.com/p/cea3fw/resign-ipa-with-new-distribution-certificate


Fonctionnement
--------------

Lorsque l'application se lance, le visiteur doit choisir son envie (une seule disponible pour ce prototype) ainsi que la durée de sa visite.

Suivant la durée de la visite (30m, 1h, 1h30, 2h), il se verra proposer respectivement 1, 2, 3, 3 oeuvres à découvrir.

Le visteur devra alors se déplacer aux endroits indiqués sur la carte présentée sur l'écran de l'iPad, et, lorsque la personne est devant l'oeuvre, elle devra pointer sa tablette vers la peinture (ou vers la feuille représentant le Geneva Circle Two) afin que la tablette présente au visiteur le contenu relatif à l'oeuvre en question.


Technologies
------------

- Augmented Reality toolkit from Vidinoti - http://www.vidinoti.com
- HTML/CSS/JavaScript
- iOS SDK


Maintenance
-----------

L'application a besoin de données qui sont téléchargées depuis Internet au premier lancement. Il faut donc **impérativement** avoir une connexion Wifi fonctionnelle sur l'iPad lors du premier lancement de l'application. Par la suite, aucune connexion n'est nécessaire.




