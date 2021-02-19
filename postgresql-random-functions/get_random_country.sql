\timing on
BEGIN;

-- Source of country names : https://www.data.gouv.fr/fr/datasets/r/10bfaf29-2d13-48a3-bf6b-7ea8725c9ff2
--
-- return : text
--
CREATE OR REPLACE FUNCTION get_random_country() returns text as
$$
DECLARE
  chars text[] := '{Afghanistan,Afrique du Sud,Albanie,Algérie,Allemagne,Andorre,Angola,Antigua-et-Barbuda,Arabie saoudite,Argentine,Arménie,Australie,Autriche,Azerbaïdjan,Bahamas,Bahreïn,Bangladesh,Barbade,Belgique,Bélize,Bénin,Bhoutan,Biélorussie,Birmanie,Bolivie,Bosnie-Herzégovine,Botswana,Brésil,Brunei,Bulgarie,Burkina,Burundi,Cambodge,Cameroun,Canada,Cap-Vert,Centrafrique,Chili,Chine,Chypre,Colombie,Comores,Congo,République démocratique du Congo,Îles Cook,Corée du Nord,Corée du Sud,Costa Rica,Côte d''Ivoire,Croatie,Cuba,Danemark,Djibouti,République dominicaine,Dominique,Égypte,Émirats arabes unis,Équateur,Érythrée,Espagne,Estonie,Eswatini,États-Unis,Éthiopie,Fidji,Finlande,France,Gabon,Gambie,Géorgie,Ghana,Grèce,Grenade,Guatémala,Guinée,Guinée équatoriale,Guinée-Bissao,Guyana,Haïti,Honduras,Hongrie,Inde,Indonésie,Irak,Iran,Irlande,Islande,Israël,Italie,Jamaïque,Japon,Jordanie,Kazakhstan,Kénya,Kirghizstan,Kiribati,Kosovo,Koweït,Laos,Lésotho,Lettonie,Liban,Libéria,Libye,Liechtenstein,Lituanie,Luxembourg,Macédoine du Nord,Madagascar,Malaisie,Malawi,Maldives,Mali,Malte,Maroc,Îles Marshall,Maurice,Mauritanie,Mexique,Micronésie,Moldavie,Monaco,Mongolie,Monténégro,Mozambique,Namibie,Nauru,Népal,Nicaragua,Niger,Nigéria,Niue,Norvège,Nouvelle-Zélande,Oman,Ouganda,Ouzbékistan,Pakistan,Palaos,Panama,Papouasie-Nouvelle-Guinée,Paraguay,Pays-Bas,Pérou,Philippines,Pologne,Portugal,Qatar,Roumanie,Royaume-Uni,Russie,Rwanda,Saint-Christophe-et-Niévès,Sainte-Lucie,Saint-Marin,Saint-Vincent-et-les-Grenadines,Salomon,Salvador,Samoa,Sao Tomé-et-Principe,Sénégal,Serbie,Seychelles,Sierra Leone,Singapour,Slovaquie,Slovénie,Somalie,Soudan,Soudan du Sud,Sri Lanka,Suède,Suisse,Suriname,Syrie,Tadjikistan,Tanzanie,Tchad,Tchéquie,Thaïlande,Timor oriental,Togo,Tonga,Trinité-et-Tobago,Tunisie,Turkménistan,Turquie,Tuvalu,Ukraine,Uruguay,Vanuatu,Vatican,Vénézuéla,Vietnam,Yémen,Zambie,Zimbabwé}';
  result text := '';

BEGIN
    result := result || chars[1+random()*(array_length(chars, 1)-1)];

    RETURN result;
END;
$$ language plpgsql;


COMMIT;
