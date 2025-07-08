# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require "open-uri"

# secreturl = 'http://res.cloudinary.com/deuesgfhi/image/upload/v1751637259/ilv5btpnx3krsgnysqyd.jpg'

puts "Cleaning database...."
Garden.destroy_all
User.destroy_all
Booking.destroy_all
Notification.destroy_all

puts "Creating users...."
jean = User.create!(
  first_name: "Jean",
  last_name: "Martinez",
  email: "JeanMartinez@hotmail.com",
  password: "password"
)
rebecca = User.create!(
  first_name: "Rebecca",
  last_name: "Claydon",
  email: "rebecca.claydon@hotmail.com",
  password: "password"
)
thomas = User.create!(
  first_name: "Thomas",
  last_name: "Feret",
  email: "thomas.feret@hotmail.fr",
  password: "password"
)
puts "Finished creating #{User.count} users!"

puts "Creating gardens"
secret = Garden.create!(
  user: jean,
  title: "Un jardin secret entre deux murs de pierre",
  description: "Derrière une porte en bois dissimulée dans un vieux mur, un petit jardin intime s’ouvre avec des roses anciennes, un banc en fer forgé à l’ombre d’un pommier, et le doux bruit d'une fontaine murmurant à côté.",
  address: "50 rue de la Paix, 75001 Paris",
  price_per_day: "50"
)
secret.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751637259/ilv5btpnx3krsgnysqyd.jpg').open, filename: "secret.jpg", content_type: "image/jpeg")

sieste = Garden.create!(
  user: jean,
  title: "Un jardin de sieste sous les oliviers",
  description: "Des oliviers torsadés projettent une ombre fraîche sur un tapis d’herbes folles. Un hamac est tendu entre deux troncs, et une brise légère transporte l’odeur du thym sauvage. Idéal pour lire, rêver ou s’endormir au chant des cigales.",
  address: "12 Rue de Rivoli, 75004 Paris",
  price_per_day: "90"
)
sieste.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751637394/srifllt3y9uawi8bcbc7.webp').open, filename: "sieste.jpg", content_type: "image/jpeg")

bordeleau = Garden.create!(
  user: jean,
  title: "Un jardin au bord de l’eau",
  description: "Un petit étang entouré de saules pleureurs accueille des nénuphars, des libellules et des canards paisibles. Une barque en bois flotte doucement, invitant à une balade silencieuse ou un pique-nique improvisé.",
  address: "78 Avenue des Champs-Élysées, 75008 Paris",
  price_per_day: "45"
)
bordeleau.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751637486/qoxi2ykpfkqft0xxaegm.jpg').open, filename: "bordeleau.jpg", content_type: "image/jpeg")

terraces = Garden.create!(
  user: rebecca,
  title: "Un jardin en terrasses d’un vieux village provençal",
  description: "Des murets de pierre sèche soutiennent des platebandes pleines de lavande, de sauge et de figuiers. Des marches irrégulières mènent à des coins secrets avec vue sur la vallée, parfaits pour peindre ou écrire.",
  address: "5 Rue Oberkampf, 75011 Paris",
  price_per_day: "56"
)
terraces.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751637414/ajceabeqxe8wnltbzlu4.webp').open, filename: "terraces.jpg", content_type: "image/jpeg")

glycine = Garden.create!(
  user: rebecca,
  title: "Un jardin de lecture sous la glycine",
  description: "Une pergola recouverte de glycines en fleurs abrite un fauteuil en osier moelleux, avec une table basse pour le thé, les livres, et quelques biscuits. Le parfum sucré des fleurs emplit l’air, et le temps ralentit.",
  address: "43 Boulevard Saint-Germain, 75005 Paris",
  price_per_day: "60"
)
glycine.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751637464/mxa8yppvzhgaplwkalay.jpg').open, filename: "glycine.jpg", content_type: "image/jpeg")

bambou = Garden.create!(
  user: rebecca,
  title: "Un jardin de bambous et de silence",
  description: "Un sentier en pierre serpente entre des bambous géants qui dansent doucement dans le vent. Des carpes koï tournent lentement dans un bassin clair, et chaque pas devient une méditation.",
  address: "15 Rue de Charonne, 75011 Paris",
  price_per_day: "53"
)
bambou.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751637432/g2hpfaqguwde6zewtdao.jpg').open, filename: "bambou.jpg", content_type: "image/jpeg")

enfance = Garden.create!(
  user: thomas,
  title: "Un jardin d’enfance plein de couleurs",
  description: "Des tournesols géants, des cabanes en bois, des fraisiers à portée de main, et des cerfs-volants accrochés aux arbres. On y entend des rires d’enfants, des jeux d’eau, et le clapotis d’un petit ruisseau à travers les cailloux.",
  address: "26 Rue de la Pompe, 75016 Paris",
  price_per_day: "46"
)
enfance.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751634207/qd4mmlr5aqm9tff0fpwh.jpg').open, filename: "enfance.jpg", content_type: "image/jpeg")

sauvage = Garden.create!(
  user: thomas,
  title: "Un jardin sauvage au bord de la forêt",
  description: "Des herbes hautes ondulent sous le vent, des coquelicots parsèment le champ, et un vieux banc en bois est caché près d’un grand chêne. On y entend les oiseaux, les grillons, et le silence du monde naturel.",
  address: "31 Rue de Belleville, 75020 Paris",
  price_per_day: "49"
)
sauvage.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751637292/zejrrqbwzujzrvcnab1w.jpg').open, filename: "sauvage.jpg", content_type: "image/jpeg")

botanique = Garden.create!(
  user: thomas,
  title: "Un jardin botanique aux mille parfums",
  description: "Des allées sinueuses traversent des serres tropicales, des jardins de roses, d’orchidées, et d’épices rares. Chaque coin est un voyage sensoriel, entre odeurs enivrantes et plantes étonnantes.",
  address: "9 Rue Saint-Denis, 75001 Paris",
  price_per_day: "53"
)
botanique.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751637377/w1cakkbtrsqnf8mpkius.jpg').open, filename: "botanique.jpg", content_type: "image/jpeg")

suspendu = Garden.create!(
  user: thomas,
  title: "Un jardin suspendu sur les toits de la ville",
  description: "Au sommet d’un immeuble, un havre de verdure flotte au-dessus du bruit urbain. Des plantes grimpantes habillent les rambardes, des coussins invitent à s’allonger, et la vue sur les toits invite à la contemplation.",
  address: "67 Rue de Vaugirard, 75006 Paris",
  price_per_day: "58"
)
suspendu.photos.attach(io: URI.parse('http://res.cloudinary.com/deuesgfhi/image/upload/v1751637207/cxgdtrgucigendximjmx.webp').open, filename: "suspendu.jpg", content_type: "image/jpeg")

puts "Finished creating #{Garden.count} gardens!"
