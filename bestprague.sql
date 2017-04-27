-- phpMyAdmin SQL Dump
-- version 4.0.10.17
-- https://www.phpmyadmin.net
--
-- Počítač: localhost:3309
-- Vygenerováno: Ned 26. úno 2017, 19:57
-- Verze serveru: 5.1.73-14.12-log
-- Verze PHP: 7.0.8-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáze: `bestprague`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `members_activities`
--

CREATE TABLE IF NOT EXISTS `members_activities` (
  `id_activity` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `points` int(45) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id_activity`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- Vypisuji data pro tabulku `members_activities`
--

INSERT INTO `members_activities` (`id_activity`, `name`, `points`, `description`) VALUES
(2, 'účast na Local Meetingu', 20, ''),
(3, 'účast na Regional Meetingu', 500, ''),
(4, 'účast na Presidents Meetingu', 800, ''),
(5, 'účast na General Meetingu', 1000, ''),
(6, 'postup na úroveň Baby member', 200, ''),
(7, 'postup na úroveň Full member', 400, ''),
(8, 'postup na úroveň Board member', 1200, ''),
(9, 'MO - velký projekt', 800, ''),
(10, 'MO - střední projekt', 400, ''),
(11, 'MO - malý projekt', 100, ''),
(12, 'člen Core Teamu - velký projekt', 500, ''),
(13, 'člen Core Teamu - střední projekt', 150, ''),
(14, 'člen Core Teamu - malý projekt', 50, ''),
(15, 'zaslání motiváku', 25, ''),
(16, 'člen mezinárodní comittee', 2000, ''),
(17, 'Regional advisor / Ambassador', 2500, ''),
(18, 'člen mezinárodního boardu', 5000, ''),
(19, 'účast na mezinárodním working eventu', 500, ''),
(20, 'pomoc na malém mezinárodním projektu', 800, ''),
(21, 'pomoc na velkém mezinárodním projektu', 1000, ''),
(22, 'úkol ve WG', 50, ''),
(23, 'výpomoc s akcí', 25, ''),
(24, 'hostování BESŤáka', 24, ''),
(25, 'hostování Turka', 100, ''),
(26, 'angel', 300, ''),
(27, 'napráskání buffalo', 5, ''),
(28, '-', 0, ''),
(29, 'výpomoc s celodenní akcí', 100, ''),
(30, 'interview', 25, ''),
(31, 'body pro body', 1, NULL),
(32, 'body', 50, NULL),
(33, 'body se šmrncem', 100, NULL),
(34, 'účast na meetingu WG (HR/PR/CR)', 20, NULL);

-- --------------------------------------------------------

--
-- Struktura tabulky `members_board_pos`
--

CREATE TABLE IF NOT EXISTS `members_board_pos` (
  `id_board_pos` int(11) NOT NULL AUTO_INCREMENT,
  `id_member` int(11) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `executive` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_board_pos`),
  KEY `fk_members_board_pos_members_member1_idx` (`id_member`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Vypisuji data pro tabulku `members_board_pos`
--

INSERT INTO `members_board_pos` (`id_board_pos`, `id_member`, `name`, `executive`) VALUES
(1, 101, 'President', 1),
(2, 94, 'VP for PR', 1),
(3, 92, 'VP for HR', 1),
(4, 91, 'VP for CR', 1),
(5, 104, 'Secretary', 1),
(6, 138, 'Treasurer', 1),
(7, 98, 'Vivaldi Responsible', 0),
(8, 142, 'IT Coordinator', 0);

-- --------------------------------------------------------

--
-- Struktura tabulky `members_member`
--

CREATE TABLE IF NOT EXISTS `members_member` (
  `id_member` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `nickname` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `joined` date DEFAULT NULL,
  `wg` varchar(10) DEFAULT NULL,
  `id_rank` int(11) NOT NULL,
  `id_angel` int(11) DEFAULT NULL,
  `telephone` varchar(13) DEFAULT NULL,
  `fb` varchar(100) DEFAULT NULL,
  `skype` varchar(45) DEFAULT NULL,
  `erasmus` varchar(45) DEFAULT NULL,
  `tshirt` varchar(15) DEFAULT NULL,
  `role` varchar(15) NOT NULL DEFAULT 'member',
  `gender` varchar(45) DEFAULT NULL,
  `google_id` varchar(50) DEFAULT NULL,
  `google_image` varchar(200) DEFAULT NULL,
  `image` varchar(200) NOT NULL,
  PRIMARY KEY (`id_member`),
  KEY `fk_members_member_members_rank1_idx` (`id_rank`),
  KEY `fk_members_member_members_member1_idx` (`id_angel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=164 ;

--
-- Vypisuji data pro tabulku `members_member`
--

INSERT INTO `members_member` (`id_member`, `name`, `surname`, `nickname`, `email`, `joined`, `wg`, `id_rank`, `id_angel`, `telephone`, `fb`, `skype`, `erasmus`, `tshirt`, `role`, `gender`, `google_id`, `google_image`, `image`) VALUES
(70, 'Alena', 'Juklová', NULL, 'alena.juklova@gmail.com', '2010-02-21', NULL, 5, NULL, '+420721981325', NULL, NULL, NULL, 'S/M', 'member', 'F', NULL, NULL, '70.png'),
(71, 'Alena', 'Nimrichtrová', 'Ála', 'animrichtrova@gmail.com', '2012-11-01', NULL, 5, NULL, '+420732555479', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL, '71.png'),
(72, 'Anna', 'Doncheva', NULL, 'anna.m.doncheva@gmail.com', '2009-09-04', NULL, 5, NULL, '+420776672799', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL, '72.png'),
(73, 'Edita', 'Dvořáková', NULL, 'edita.dvo@gmail.com', '2012-05-21', NULL, 5, 127, '+420739037799', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL, '73.png'),
(74, 'Jaroslav', 'Hrubý', NULL, 'profik@spk.cz', '2010-10-01', NULL, 5, NULL, '+420777746117', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL, '74.png'),
(75, 'Jaroslav', 'Marek', NULL, 'maslic@gmail.com', '2008-07-01', NULL, 5, NULL, '+420605296306', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL, '75.png'),
(76, 'Jiri', 'Kotlan', NULL, 'kotlan.jiri@centrum.cz', '2012-05-21', NULL, 5, 78, '+420777810535', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL, '76.png'),
(77, 'Karel', 'Šimek', NULL, 'karelsurfer@googlemail.com', '2009-07-01', NULL, 5, NULL, '+420776554737', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL, '77.png'),
(78, 'Kateřina', 'Indrová', NULL, 'indrova.katka@gmail.com', '2011-04-21', NULL, 5, 70, '+420777676233', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL, '78.png'),
(79, 'Lucie', 'Buzková', NULL, 'lucka.buzkova@gmail.com', '2012-10-21', NULL, 5, 73, '+420728401211', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL, '79.png'),
(80, 'Marek', 'Pesta', NULL, 'marekpesta@gmail.com', '2011-10-01', NULL, 5, NULL, '+420724371322', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL, '80.png'),
(81, 'Marketa', 'Hildebrandtová', NULL, 'marketa@hildebrandtova.cz', '2010-09-01', NULL, 5, NULL, '+420731637173', NULL, NULL, NULL, 'S', 'member', 'F', NULL, NULL, '81.png'),
(82, 'Michal', 'Čáp', NULL, 'michal.cap@email.cz', '2010-11-01', NULL, 5, NULL, '+420774227466', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL, '82.png'),
(83, 'Michal', 'Šustr', NULL, 'michal.sustr@gmail.com', '2012-06-01', NULL, 5, NULL, '+420734601300', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL, '83.png'),
(84, 'Petr', 'Kopecký', NULL, 'peta.kopecky@gmail.com', '2011-09-01', NULL, 5, NULL, '+420723748569', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL, '84.png'),
(85, 'Petr', 'Vála', NULL, 'petr.m.vala@gmail.com', '2012-01-01', NULL, 5, NULL, '+420723888512', NULL, 'petr..vala', NULL, NULL, 'member', 'M', NULL, NULL, '85.png'),
(86, 'Ramona', 'Sanigová', NULL, 'ramushka@gmail.com', '2011-09-01', NULL, 5, NULL, '+420736425023', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL, '86.png'),
(87, 'Zdenek', 'Pecka', NULL, 'peckazde@gmail.com', '2012-05-21', NULL, 5, 81, '+420731002695', 'https://www.facebook.com/peckazde?fref=ts', 'peckazde', NULL, NULL, 'member', 'M', NULL, NULL, '87.png'),
(88, 'Šárka', 'Dragounová', NULL, 'sarkadrag@gmail.com', '2010-10-01', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL, '88.png'),
(89, 'Adam', 'Uhlíř', NULL, 'uhlir.a@gmail.com', '2012-05-01', NULL, 5, 127, '+420607963319', 'https://www.facebook.com/uhlir.a?fref=ts', 'uhlir.a', NULL, 'L', 'member', 'M', NULL, NULL, '89.png'),
(90, 'Gabriela', 'Kadlecová', NULL, 'kadlecova.g@gmail.com', '2012-05-01', NULL, 5, 74, '+420605713607', 'https://www.facebook.com/gabrielak1?ref=ts&fref=ts', 'gabasek77', NULL, 'M', 'member', 'F', NULL, NULL, '90.png'),
(91, 'Martin', 'Růžička', 'Martins', 'martinr.mr@gmail.com', '2014-07-30', 'CR', 4, 134, '+420777312393', 'https://www.facebook.com/martin.ruzicka.37051?fref=ts', NULL, NULL, 'M', 'admin', 'M', '115779569032645361215', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '91.png'),
(92, 'Vojta', 'Dlápal', 'Vojtas', 'sadlomasloskvarky@gmail.com', '2014-10-30', 'CR', 4, 134, '+420606357714', 'https://www.facebook.com/vojta.dlapal', 'sadlomasloskvarky', NULL, 'M', 'admin', 'M', '116806164621879767628', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '92.png'),
(93, 'Aneta', 'Šnellerová', NULL, 'aneta.snellerova@gmail.com', '2015-11-27', 'PR', 7, 131, '+420732581541', 'https://www.facebook.com/aneta.snellerova?fref=ts', NULL, NULL, NULL, 'member', 'F', '101798190882923449757', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '93.png'),
(94, 'Kateřina', 'Holetová', NULL, 'kat.holetova@gmail.com', '2015-04-30', 'PR', 4, 130, '+420774367442', 'https://www.facebook.com/kata.holetova?fref=ts', NULL, NULL, 'M', 'admin', 'F', '103919265445912663102', 'https://lh4.googleusercontent.com/-58bB0NuaWzg/AAAAAAAAAAI/AAAAAAAAAEM/9lwD2LrwedE/photo.jpg', '94.jpg'),
(95, 'Radka', 'Vopatová', NULL, 'vopatova.radka@gmail.com', '2015-07-11', 'PR', 2, 108, '+420776587305', 'https://www.facebook.com/vopatrad?fref=ts', NULL, NULL, 'M', 'member', 'F', '102096720175391167082', 'https://lh3.googleusercontent.com/-CAQFGQqKyNg/AAAAAAAAAAI/AAAAAAAAAn4/TH0Aam95vc8/photo.jpg', '95.jpeg'),
(96, 'Tomáš', 'Jelínek', 'Jelen', 'tomas.jelinek.91@gmail.com', '2015-11-26', 'PR', 3, 127, '+420605720748', 'https://www.facebook.com/tomas.jelinek.56?fref=ts', NULL, NULL, 'XXL', 'member', 'M', '115206372649878937308', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '96.png'),
(97, 'Bui Phu', 'Hai', 'Haiß', 'buiphuhai91@gmail.com', '2015-11-10', 'CR', 3, 106, '+420608738308', 'https://www.facebook.com/buiphuhai', NULL, NULL, 'M', 'member', 'M', '112197486509364422177', 'https://lh6.googleusercontent.com/-Pyexwq1aBbU/AAAAAAAAAAI/AAAAAAAACS8/DVo2swQkns4/photo.jpg', '97.jpg'),
(98, 'Karolína', 'Berková', NULL, 'karol.berkova@gmail.com', '2015-10-01', 'HR', 4, 105, '+420722198716', 'https://www.facebook.com/profile.php?id=1335178202', NULL, NULL, 'M', 'admin', 'F', '107496236023293841145', 'https://lh3.googleusercontent.com/-Eiy977JHzVk/AAAAAAAAAAI/AAAAAAAAAKQ/5vQuRrrmut8/photo.jpg', '98.jpg'),
(99, 'Jan', 'Orihel', NULL, 'jan.orihel7@gmail.com', '2014-10-27', 'CR', 7, 126, '+420602745050', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL, '99.png'),
(100, 'Zdeněk', 'Šlégl', 'Zdeněks', 'zdenek.slegl@gmail.com', '2014-10-28', 'CR', 2, 128, '+420728977929', 'https://www.facebook.com/zdenek.slegl', NULL, NULL, 'L', 'member', 'M', '116170293231012583696', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '100.png'),
(101, 'Petr', 'Jirásko', 'Jitr', 'jiraspe2@gmail.com', '2014-10-08', 'PR', 4, 122, '+420723413160', 'https://www.facebook.com/petr.jirasko.7', NULL, NULL, 'L', 'admin', 'M', '111340492575035657377', 'https://lh4.googleusercontent.com/-m0nkESRKkT4/AAAAAAAAAAI/AAAAAAAAAEA/nkFAOGEO5-Q/photo.jpg', '101.jpg'),
(102, 'Martin', 'Svatoš', NULL, 'martinsvat@gmail.com', NULL, 'PR', 7, 134, '+420721331022', 'https://www.facebook.com/e1b4574rd0?fref=ts', NULL, NULL, NULL, 'member', 'M', NULL, NULL, '102.png'),
(103, 'Lucie', 'Marcalíková', NULL, 'luciemarcalikova@gmail.com', '2015-11-19', 'HR', 7, 125, '+420732131321', 'https://www.facebook.com/profile.php?id=100005009568726&fref=ts', NULL, NULL, 'S', 'member', 'F', '112555173739173030993', 'https://lh3.googleusercontent.com/-ClnkurWGLRM/AAAAAAAAAAI/AAAAAAAAAIk/e9qEtvSR9zY/photo.jpg', '103.jpg'),
(104, 'Nicola', 'Kyjevská', NULL, 'kyjevska.nicol@gmail.com ', '2015-10-01', NULL, 4, 133, '+420728599260', 'https://www.facebook.com/nicola.kyjevska', NULL, NULL, 'M', 'admin', 'F', '106518781665734565246', 'https://lh6.googleusercontent.com/-Lpw0u6vIkdw/AAAAAAAAAAI/AAAAAAAAAO8/M2bQlIirHnQ/photo.jpg', '104.jpg'),
(105, 'Vojta', 'Hájek', 'Kojtas', 'hajek.vojtech@gmail.com', '2015-07-10', 'CR', 3, 107, '+420733543482', 'https://www.facebook.com/hajek.vojtech?ref=ts&fref=ts', NULL, NULL, 'M', 'member', 'M', '109242322011176480194', 'https://lh5.googleusercontent.com/-TKa0GzJJkfk/AAAAAAAAAAI/AAAAAAAAAEI/YSfBCEKFegA/photo.jpg', '105.jpg'),
(106, 'Hana', 'Morávková', NULL, 'Hana.moravkova611@gmail.com', '2015-04-30', NULL, 3, 132, '+420607706773', 'https://www.facebook.com/moravkova.hana?fref=ts', NULL, NULL, 'S', 'member', 'F', '112596474200990034579', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '106.png'),
(107, 'Sylvie', 'Horváthová', NULL, 'sylvinkyhtc@gmail.com', '2014-10-30', 'PR', 3, 89, '+420737184376', 'https://www.facebook.com/sylvie.horvathova', 'sylwana_from_cz', NULL, 'L', 'member', 'F', '107056950087460792329', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '107.png'),
(108, 'Zdeněk', 'Kasner', NULL, 'zdenek.kasner@gmail.com', '2014-10-06', 'PR', 3, 124, '+420721824283', 'https://www.facebook.com/zdenek.kasner', NULL, NULL, 'L', 'admin', 'M', '118335767426874674196', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '108.jpg'),
(109, 'Adam', 'Kučera', 'Adams', 'wrent00@gmail.com', '2012-09-25', 'CR', 5, 70, '+420608921904', 'https://www.facebook.com/Wrent00?fref=ts', 'wrent00', NULL, 'L', 'guest', 'M', '115043252509922068003', 'https://lh6.googleusercontent.com/-2oAc1zjbzGA/AAAAAAAAAAI/AAAAAAAAYwo/l14bgs5sOTE/photo.jpg', '109.jpg'),
(110, 'Petra', 'Martišková', NULL, 'martiskova.p@seznam.cz', '2014-10-19', NULL, 7, 125, '+420724171423', 'https://www.facebook.com/petra.martiskova.3', NULL, NULL, 'M', 'member', 'F', '103665471938817608909', 'https://lh5.googleusercontent.com/-9N8QLYNH0BM/AAAAAAAAAAI/AAAAAAAAABM/aOWNn5zGyf4/photo.jpg', '110.jpg'),
(111, 'Dalibor', 'Pospíšil', 'Libors', 'pospisil.dalibor@gmail.com', '2014-10-08', 'CR', 3, 124, '+420775996704', 'https://www.facebook.com/dalibor.pospisil.1?fref=ts', NULL, NULL, 'M', 'member', 'M', '101108101519143059859', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '111.png'),
(112, 'Vašek', 'Michalec', 'Vašik', 'vaclav.michalec@gmail.com', '2015-04-14', 'HR', 3, 123, '+420605174943', 'https://www.facebook.com/vasek.michalec?fref=ts', NULL, NULL, 'XL', 'member', 'M', '102676211932994450687', 'https://lh4.googleusercontent.com/-eFfq3nDymJw/AAAAAAAAAAI/AAAAAAAAB_E/o3enfZIlAcQ/photo.jpg', '112.jpg'),
(113, 'Martina', 'Češková', NULL, ' martina.ceskova@gmail.com', NULL, NULL, 7, 126, '+420605981671', 'https://www.facebook.com/ceskova.martina?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '113.png'),
(114, 'Maťo', 'Koyš', NULL, 'mato.koys01@gmail.com', NULL, NULL, 7, 124, '+420607688562', 'https://www.facebook.com/mato.koys?fref=ts', NULL, NULL, NULL, 'member', 'M', NULL, NULL, '114.png'),
(115, 'Mirka', 'Blahutová', NULL, 'blahutovamirka@gmail.com', NULL, NULL, 7, 133, '+420732709309', 'https://www.facebook.com/Jahoodka69?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '115.png'),
(116, 'Simona', 'Strnadová', NULL, 'strnadova.simi@gmail.com', NULL, NULL, 7, 133, '+420728003523', 'https://www.facebook.com/slunicko?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '116.png'),
(117, 'Violetta', 'Ladukayte', NULL, 'violetta.ladukayte@gmail.com', '2012-05-01', 'HR', 7, 86, '+420608831070', 'https://www.facebook.com/violetta.ladukayte?fref=ts', 'violetta489', NULL, 'S', 'member', 'F', NULL, NULL, '117.png'),
(118, 'Jan', 'Fojt', NULL, 'john.generix@gmail.com', NULL, NULL, 5, NULL, '+420603891957', 'https://www.facebook.com/honzik.fojt?fref=ts', NULL, NULL, 'L', 'member', 'M', NULL, NULL, '118.png'),
(119, 'Adam', 'Kozel', NULL, 'adamkozel.aust@gmail.com', NULL, NULL, 7, 81, '+420728915553', 'https://www.facebook.com/adam.kozel.3?fref=ts', NULL, NULL, NULL, 'member', 'M', NULL, NULL, '119.png'),
(120, 'Angelika', 'Pruchová', NULL, 'angelika.pruchova@gmail.com', NULL, NULL, 7, 90, '+420777302080', 'https://www.facebook.com/angi.pruchova?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '120.png'),
(121, 'Jaroslav', 'Hanák', NULL, 'jaroslavhanak42@gmail.com', '2014-10-27', 'CR', 3, 126, '+420739040359', 'https://www.facebook.com/Jarda.Hanak', NULL, NULL, 'L', 'member', 'M', '107762697795411302071', 'https://lh6.googleusercontent.com/-SPnX5-zfiYU/AAAAAAAAAAI/AAAAAAAAABE/pITT2TiUjG8/photo.jpg', '121.jpg'),
(122, 'Pavlína', 'Nykodémová', NULL, 'pavlina.nykodemova@gmail.com', '2014-02-28', 'HR', 3, 120, '+420721537149', 'https://www.facebook.com/pavlina.nykodemova?fref=ts', NULL, NULL, 'M', 'member', 'F', '101179032596618482913', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '122.png'),
(123, 'Jitka', 'Jeníková', NULL, 'jenikova.jitka.jj@gmail.com', '2014-04-27', 'HR', 3, 131, '+420736455800', 'https://www.facebook.com/jitka.jenikova.3?fref=ts', NULL, NULL, 'XL', 'member', 'F', '107106448913838860048', 'https://lh6.googleusercontent.com/-L6M_oIhPeig/AAAAAAAAAAI/AAAAAAAAAGY/fCyZ-ZRNbuI/photo.jpg', '123.jpg'),
(124, 'Lucka', 'Linderová', NULL, 'lucie.linderova@gmail.com', '2013-05-13', 'HR', 6, 79, '+420739524666', 'https://www.facebook.com/lucka.linderova?fref=ts', NULL, NULL, 'M', 'member', 'F', '115843542211774093324', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '124.png'),
(125, 'Lukáš', 'Vondra', NULL, 'vondra.ctu@gmail.com', '2012-10-28', 'PR', 3, 73, '+420605967315', 'https://www.facebook.com/lukas.vondra.1?fref=ts', NULL, NULL, 'L', 'member', 'M', '101818670828374517650', 'https://lh5.googleusercontent.com/-iaENO-MptLc/AAAAAAAAAAI/AAAAAAAAAG4/bCmP8wa2fPU/photo.jpg', '125.jpg'),
(126, 'Tomáš', 'Budil', 'Tomášs', 'mr.pheb@gmail.com', '2013-02-09', 'CR', 5, 71, '+420731283550', 'https://www.facebook.com/tbudil?fref=ts', 'phebbb', NULL, 'L', 'member', 'M', '116585273808105931090', 'https://lh4.googleusercontent.com/-bUN1GBhTknI/AAAAAAAAAAI/AAAAAAAAAB0/z6dA-R_A9i0/photo.jpg', '126.jpg'),
(127, 'Milan', 'Poláček', NULL, 'polacek.emilan@gmail.com', '2011-10-31', 'HR', 3, 88, '+420605733249', 'https://www.facebook.com/Mr.Milan.Polacek', 'Milan_von_Teuflice', NULL, 'L', 'member', 'M', '110900917130374653576', 'https://lh4.googleusercontent.com/-DNF5hZ0x-Xw/AAAAAAAAAAI/AAAAAAAAAKo/QAxSIeDJUq0/photo.jpg', '127.jpg'),
(128, 'Andrea', 'Schejbalová', 'Andy', 'schejbalova.andrejka@gmail.com', '2013-09-01', NULL, 7, 89, '+420608878840', 'https://www.facebook.com/aschejbalova?fref=ts', 'andreejka8', NULL, 'M', 'member', 'F', NULL, NULL, '128.png'),
(129, 'Barča', 'Drahorádová', NULL, 'drahoradova.barca@gmail.com', '2013-05-03', 'HR', 3, 109, '+420602940537', 'https://www.facebook.com/drahoradova.barca?fref=ts', 'beruska_barca', NULL, 'M', 'member', 'F', '106274892394054240186', 'https://lh3.googleusercontent.com/-6HmZcPmERvg/AAAAAAAAAAI/AAAAAAAAJ_I/6_o0H_uxqWo/photo.jpg', '129.jpg'),
(130, 'Honza', 'Předota', 'Předotas', 'predota.honza@gmail.com', '2014-10-03', 'CR', 3, 129, '+420728448266', 'https://www.facebook.com/jan.predota', 'honpre', NULL, 'M', 'member', 'M', '115792857557759094183', 'https://lh4.googleusercontent.com/-UYL3Z1BNK3g/AAAAAAAAAAI/AAAAAAAAAF8/qBuggYvK5k0/photo.jpg', '130.jpg'),
(131, 'Petr', 'Jarušek', 'Jetter', 'petrjarusek@gmail.com', '2013-10-02', 'Spirit', 3, 124, '+420608338317', 'https://www.facebook.com/petrjarusek?fref=ts', NULL, NULL, 'L', 'admin', 'M', '107561164286174176014', 'https://lh4.googleusercontent.com/-cBkIGn104yk/AAAAAAAAAAI/AAAAAAAABYY/kAPFXVZRQ1Q/photo.jpg', '131.jpg'),
(132, 'Petr', 'Novák', 'Speedy', 'netr.povak@gmail.com', '2013-10-01', NULL, 3, 117, '+420776009727', 'https://www.facebook.com/petr.s.novak?fref=ts', 'D.evil_Speedy', NULL, 'M', 'member', 'M', '110024337337010848371', 'https://lh4.googleusercontent.com/-C1qD3HnCLus/AAAAAAAAAAI/AAAAAAAAAF8/2FvxyfLXEoM/photo.jpg', '132.jpg'),
(133, 'David', 'Příhoda', NULL, 'david.prihoda@gmail.com', '2013-02-07', 'HR', 3, 89, '+420728921350', 'https://www.facebook.com/d.prihoda?fref=ts', NULL, NULL, 'XL', 'admin', 'M', '117837490822947964582', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '133.jpg'),
(134, 'Víťa', 'Štván', 'Víťas', 'v.stvan@gmail.com', NULL, 'CR', 5, 109, '+420608051908', 'https://www.facebook.com/vita.stvan?fref=ts', 'kouzelnik.v', NULL, 'L', 'member', 'M', '104426860468081989026', 'https://lh5.googleusercontent.com/-IiL4xDmtUE8/AAAAAAAAAAI/AAAAAAAAAxw/xSKa1VOUihc/photo.jpg', '134.jpg'),
(135, 'Heda', 'Jakubův', NULL, 'heda.jakubuv@gmail.com', '2015-12-14', 'HR', 2, 112, '+420723175261', 'https://www.facebook.com/Hedus', NULL, NULL, 'XS-S', 'member', 'F', '112719324614896759018', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '135.png'),
(137, 'Michal', 'Kocánek', 'Hřebeček', 'kocanek.m@gmail.com', '2016-02-05', 'CR', 3, 107, '+420728658501', 'https://www.facebook.com/michal.kocanek', NULL, NULL, 'M', 'admin', 'M', '117728965119177100240', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '137.png'),
(138, 'František', 'Nekovář', 'Frodos', 'fnekovar@gmail.com', '2016-02-06', 'PR', 4, 109, '+420773691550', 'https://www.facebook.com/frantisek.nekovar', NULL, NULL, 'L', 'member', 'M', '115717313891738095667', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '138.png'),
(141, 'Jirka', 'Vastl', 'Dortík', 'wastlik1@gmail.com', '2016-03-07', 'PR', 3, 129, '+420723311326', 'https://www.facebook.com/jirka.vastl', NULL, NULL, 'M', 'member', 'M', '112452133550939299517', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '141.png'),
(142, 'David', 'Janoušek', 'Javid', 'edavidjanousek@gmail.com', '2016-04-30', 'PR', 4, 94, '+420730571844', 'https://www.facebook.com/profile.php?id=100011464778172&fref=ts', NULL, NULL, NULL, 'admin', 'M', '106558671216957130665', 'https://lh3.googleusercontent.com/-FFWN1pieA2E/AAAAAAAAAAI/AAAAAAAAAMg/1wwOHMp47S8/photo.jpg', '142.png'),
(143, 'Martina', 'Vaněčková', NULL, 'vaneckova.marti@gmail.com', '2016-04-13', NULL, 7, 112, '+420777171898', 'https://www.facebook.com/martina.p.vaneckova', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '143.png'),
(151, 'Klaudie', 'Hristova', NULL, 'k.hristova@seznam.cz', '2016-05-13', NULL, 7, 91, NULL, 'https://www.facebook.com/rikiki?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '151.png'),
(152, 'Tereza', 'Vacková', NULL, 'vackovat@gmail.com', '2016-04-03', NULL, 1, 133, '+420737058717', 'https://www.facebook.com/tereza.vackova.71?fref=ts', NULL, NULL, NULL, 'member', 'F', '116235436102644137236', 'https://lh6.googleusercontent.com/-WR1-dH5-XkE/AAAAAAAAAAI/AAAAAAAAAB0/4tHbCX7kUww/photo.jpg', '152.jpg'),
(153, 'Jan', 'Špale', 'Špalík', 'jan.spale96@gmail.com', '2016-07-05', 'PR', 3, 112, '+420723414693', 'https://www.facebook.com/jan.spale', NULL, NULL, 'L', 'member', 'M', '114567847985079308733', 'https://lh4.googleusercontent.com/-T3AUiGBjLps/AAAAAAAAAAI/AAAAAAAANNA/VduXhbJYNW4/photo.jpg', '153.jpg'),
(154, 'Martin', 'Koliba', NULL, 'martin.koliba@gmail.com', '2016-10-20', 'CR', 2, 127, '+420728274482', 'https://www.facebook.com/mkoliba', NULL, NULL, NULL, 'member', 'M', '109051404896744253679', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg', '154.png'),
(157, 'Vendula', 'Hájková', NULL, 'Vendul.hajkova@gmail.com', '2016-10-09', NULL, 2, 123, NULL, 'https://www.facebook.com/vendula.hajkova.92', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '157.png'),
(159, 'Veronika', 'Maloušková', NULL, 'veruu26@gmail.com', '2016-11-04', NULL, 1, 131, NULL, 'https://www.facebook.com/verromal', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '159.png'),
(160, 'Ondřej', 'Pešek', NULL, 'pesej.ondrek@gmail.com', '2016-11-25', NULL, 1, 127, '+420736162364', 'https://www.facebook.com/ondrej.pesek.35', NULL, NULL, NULL, 'member', 'M', NULL, NULL, '160.png'),
(161, 'Anna', 'Rojková', NULL, 'anna.rojko@gmail.com', '2017-02-20', NULL, 1, 92, NULL, 'https://www.facebook.com/anna.rojkova.3', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '161.png'),
(162, 'Zbyněk', 'Škoda', NULL, 'Zb.skoda@gmail.com', '2017-02-20', NULL, 1, 98, NULL, 'https://www.facebook.com/zbynek.skoda', NULL, NULL, NULL, 'member', 'M', NULL, NULL, '162.png'),
(163, 'Petra', 'Millarová', NULL, 'petramillarova@gmail.com', '2017-01-25', NULL, 1, 153, NULL, 'https://www.facebook.com/petramillar', NULL, NULL, NULL, 'member', 'F', NULL, NULL, '163.png');

-- --------------------------------------------------------

--
-- Struktura tabulky `members_points`
--

CREATE TABLE IF NOT EXISTS `members_points` (
  `id_points` int(11) NOT NULL AUTO_INCREMENT,
  `id_batch` int(11) NOT NULL,
  `id_member` int(11) DEFAULT NULL,
  `id_activity` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_points`),
  KEY `id_activity` (`id_activity`),
  KEY `id_member` (`id_member`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=502 ;

--
-- Vypisuji data pro tabulku `members_points`
--

INSERT INTO `members_points` (`id_points`, `id_batch`, `id_member`, `id_activity`, `points`, `name`, `description`, `datetime`, `approved`) VALUES
(137, 3, 109, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(138, 3, 97, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(139, 3, 111, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(140, 3, 142, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(141, 3, 133, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(142, 3, 138, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(143, 3, 106, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(144, 3, 153, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(145, 3, 141, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(146, 3, 123, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(147, 3, 98, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(148, 3, 94, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(149, 3, 154, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(150, 3, 137, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(151, 3, 127, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(152, 3, 122, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(153, 3, 131, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(154, 3, 107, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(155, 3, 152, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(156, 3, 112, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(157, 3, 100, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(158, 3, 108, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(161, 4, 157, 2, NULL, NULL, NULL, '2016-10-05 00:00:00', 1),
(162, 5, 125, 2, NULL, NULL, NULL, '2016-10-03 00:00:00', 1),
(163, 6, 133, 23, NULL, 'Žij Studentský Život', 'účast na stánku', '2016-10-05 00:00:00', 1),
(164, 6, 153, 23, NULL, 'Žij Studentský Život', 'účast na stánku', '2016-10-05 00:00:00', 1),
(165, 6, 123, 23, NULL, 'Žij Studentský Život', 'účast na stánku', '2016-10-05 00:00:00', 1),
(166, 6, 94, 23, NULL, 'Žij Studentský Život', 'účast na stánku', '2016-10-05 00:00:00', 1),
(167, 6, 104, 23, NULL, 'Žij Studentský Život', 'účast na stánku', '2016-10-05 00:00:00', 1),
(168, 6, 131, 23, NULL, 'Žij Studentský Život', 'účast na stánku', '2016-10-05 00:00:00', 1),
(169, 6, 101, 23, NULL, 'Žij Studentský Život', 'účast na stánku', '2016-10-05 00:00:00', 1),
(170, 7, 133, 28, 25, 'IT developers meeting', 'účast na meetingu', '2016-10-20 00:00:00', 1),
(171, 7, 142, 28, 25, 'IT developers meeting', 'účast na meetingu', '2016-10-20 00:00:00', 1),
(172, 7, 154, 28, 25, 'IT developers meeting', 'účast na meetingu', '2016-10-20 00:00:00', 1),
(173, 7, 137, 28, 25, 'IT developers meeting', 'účast na meetingu', '2016-10-20 00:00:00', 1),
(174, 7, 131, 28, 25, 'IT developers meeting', 'účast na meetingu', '2016-10-20 00:00:00', 1),
(175, 7, 108, 28, 25, 'IT developers meeting', 'účast na meetingu', '2016-10-20 00:00:00', 1),
(176, 8, 97, 28, 25, 'kafe stánek EBEC', NULL, '2016-10-20 00:00:00', 1),
(177, 8, 133, 28, 25, 'kafe stánek EBEC', NULL, '2016-10-20 00:00:00', 1),
(178, 8, 141, 28, 25, 'kafe stánek EBEC', NULL, '2016-10-20 00:00:00', 1),
(179, 8, 131, 28, 25, 'kafe stánek EBEC', NULL, '2016-10-20 00:00:00', 1),
(180, 9, 127, 28, 25, 'Přednáška na strojárně', NULL, '2016-10-27 00:00:00', 1),
(181, 9, 131, 28, 25, 'Přednáška na strojárně', NULL, '2016-10-27 00:00:00', 1),
(182, 10, 133, 28, 25, 'SAF stánek', NULL, '2016-10-26 00:00:00', 1),
(183, 10, 153, 28, 25, 'SAF stánek', NULL, '2016-10-26 00:00:00', 1),
(184, 10, 94, 28, 25, 'SAF stánek', NULL, '2016-10-26 00:00:00', 1),
(185, 10, 127, 28, 25, 'SAF stánek', NULL, '2016-10-26 00:00:00', 1),
(186, 10, 131, 28, 25, 'SAF stánek', NULL, '2016-10-26 00:00:00', 1),
(187, 10, 112, 28, 25, 'SAF stánek', NULL, '2016-10-26 00:00:00', 1),
(188, 10, 108, 28, 25, 'SAF stánek', NULL, '2016-10-26 00:00:00', 1),
(190, 12, 129, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(191, 12, 97, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(192, 12, 111, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(193, 12, 133, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(194, 12, 142, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(195, 12, 138, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(196, 12, 106, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(197, 12, 153, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(198, 12, 121, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(199, 12, 123, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(200, 12, 94, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(201, 12, 125, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(202, 12, 91, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(203, 12, 154, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(204, 12, 137, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(205, 12, 127, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(206, 12, 104, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(207, 12, 122, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(208, 12, 101, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(209, 12, 132, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(210, 12, 131, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(211, 12, 96, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(212, 12, 112, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(213, 12, 157, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(214, 12, 159, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(215, 12, 92, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(216, 12, 100, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(217, 12, 108, 2, NULL, NULL, NULL, '2016-11-01 00:00:00', 1),
(218, 13, 109, 23, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(219, 13, 111, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(220, 13, 133, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(221, 13, 138, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(222, 13, 94, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(223, 13, 125, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(224, 13, 154, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(225, 13, 91, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(226, 13, 127, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(227, 13, 104, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(228, 13, 122, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(229, 13, 131, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(230, 13, 112, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(231, 13, 157, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(232, 13, 105, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(233, 13, 92, 23, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(234, 13, 100, 29, NULL, 'organizace EBEC 2017', 'výpomoc v den soutěže', '2016-11-09 00:00:00', 1),
(235, 14, 142, 12, NULL, 'Core Team - EBEC 2017', NULL, '2016-11-09 00:00:00', 1),
(236, 14, 153, 12, NULL, 'Core Team - EBEC 2017', NULL, '2016-11-09 00:00:00', 1),
(237, 14, 141, 12, NULL, 'Core Team - EBEC 2017', NULL, '2016-11-09 00:00:00', 1),
(238, 14, 123, 12, NULL, 'Core Team - EBEC 2017', NULL, '2016-11-09 00:00:00', 1),
(239, 14, 98, 12, NULL, 'Core Team - EBEC 2017', NULL, '2016-11-09 00:00:00', 1),
(240, 14, 137, 12, NULL, 'Core Team - EBEC 2017', NULL, '2016-11-09 00:00:00', 1),
(241, 14, 152, 12, NULL, 'Core Team - EBEC 2017', NULL, '2016-11-09 00:00:00', 1),
(242, 14, 108, 12, NULL, 'Core Team - EBEC 2017', NULL, '2016-11-09 00:00:00', 1),
(243, 15, 97, 9, NULL, 'MO - EBEC 2017', NULL, '2016-11-09 00:00:00', 1),
(244, 16, 98, 26, NULL, 'Angel - Zbyněk Škoda', NULL, '2016-11-29 00:00:00', 1),
(245, 17, 123, 26, NULL, 'Angel - Vendy', NULL, '2016-11-02 00:00:00', 1),
(246, 18, 131, 26, NULL, 'Angel - Verča', NULL, '2016-11-02 00:00:00', 1),
(247, 19, 127, 26, NULL, 'Angel - Martin Koliba', NULL, '2016-11-02 00:00:00', 1),
(248, 20, 153, 7, NULL, NULL, NULL, '2016-11-28 00:00:00', 1),
(249, 20, 141, 7, NULL, NULL, NULL, '2016-11-28 00:00:00', 1),
(250, 20, 137, 7, NULL, NULL, NULL, '2016-11-28 00:00:00', 1),
(251, 21, 127, 10, NULL, 'MO - MW', NULL, '2016-12-05 00:00:00', 1),
(252, 22, 91, 10, NULL, 'MO - Hackaton', NULL, '2016-12-05 00:00:00', 1),
(253, 23, 96, 22, NULL, NULL, 'vánoční přání', '2016-12-05 00:00:00', 1),
(254, 24, 153, 28, 25, 'Spirit Meeting', NULL, '2016-11-28 00:00:00', 1),
(255, 24, 91, 28, 25, 'Spirit Meeting', NULL, '2016-11-28 00:00:00', 1),
(256, 24, 137, 28, 25, 'Spirit Meeting', NULL, '2016-11-28 00:00:00', 1),
(257, 24, 131, 28, 25, 'Spirit Meeting', NULL, '2016-11-28 00:00:00', 1),
(258, 24, 132, 28, 25, 'Spirit Meeting', NULL, '2016-11-28 00:00:00', 1),
(259, 24, 157, 28, 25, 'Spirit Meeting', NULL, '2016-11-28 00:00:00', 1),
(260, 25, 133, 28, 25, 'Uspořádání akce pro snížení počtu hejtů a unicornů v mailech', 'chlastačka', '2016-12-02 00:00:00', 1),
(261, 26, 122, 22, NULL, NULL, 'KKK prosinec', '2016-12-01 00:00:00', 1),
(262, 27, 123, 2, NULL, 'HR meeting', NULL, '2016-11-22 00:00:00', 1),
(263, 27, 127, 2, NULL, 'HR meeting', NULL, '2016-11-22 00:00:00', 1),
(264, 27, 122, 2, NULL, 'HR meeting', NULL, '2016-11-22 00:00:00', 1),
(265, 27, 92, 2, NULL, 'HR meeting', NULL, '2016-11-22 00:00:00', 1),
(266, 28, 97, 23, 25, NULL, 'rozebírání Merkuru', '2016-12-01 00:00:00', 1),
(267, 28, 141, 23, 25, NULL, 'rozebírání Merkuru', '2016-12-01 00:00:00', 1),
(268, 28, 125, 23, 25, NULL, 'rozebírání Merkuru', '2016-12-01 00:00:00', 1),
(269, 28, 137, 23, 25, NULL, 'rozebírání Merkuru', '2016-12-01 00:00:00', 1),
(270, 28, 104, 23, 25, NULL, 'rozebírání Merkuru', '2016-12-01 00:00:00', 1),
(271, 28, 152, 23, 25, NULL, 'rozebírání Merkuru', '2016-12-01 00:00:00', 1),
(272, 28, 157, 23, 25, NULL, 'rozebírání Merkuru', '2016-12-01 00:00:00', 1),
(273, 28, 100, 23, 25, NULL, 'rozebírání Merkuru', '2016-12-01 00:00:00', 1),
(274, 29, 100, 28, 20, 'MO - MW Newbie Coordinator', NULL, '2016-11-28 00:00:00', 1),
(275, 30, 101, 4, NULL, NULL, NULL, '2016-11-07 00:00:00', 1),
(276, 31, 109, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(277, 31, 97, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(278, 31, 141, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(279, 31, 123, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(280, 31, 94, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(281, 31, 91, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(282, 31, 137, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(283, 31, 104, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(284, 31, 131, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(285, 31, 112, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(286, 31, 92, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(287, 31, 100, 23, NULL, 'kafestánek', NULL, '2016-11-14 00:00:00', 1),
(288, 32, 97, 23, NULL, 'kafestánek', NULL, '2016-11-22 00:00:00', 1),
(289, 32, 153, 23, NULL, 'kafestánek', NULL, '2016-11-22 00:00:00', 1),
(290, 32, 123, 23, NULL, 'kafestánek', NULL, '2016-11-22 00:00:00', 1),
(291, 32, 125, 23, NULL, 'kafestánek', NULL, '2016-11-22 00:00:00', 1),
(292, 32, 154, 23, NULL, 'kafestánek', NULL, '2016-11-22 00:00:00', 1),
(293, 32, 137, 23, NULL, 'kafestánek', NULL, '2016-11-22 00:00:00', 1),
(294, 33, 153, 23, NULL, 'kafestánek', NULL, '2016-11-24 00:00:00', 1),
(295, 33, 104, 23, NULL, 'kafestánek', NULL, '2016-11-24 00:00:00', 1),
(296, 33, 157, 23, NULL, 'kafestánek', NULL, '2016-11-24 00:00:00', 1),
(297, 33, 92, 23, NULL, 'kafestánek', NULL, '2016-11-24 00:00:00', 1),
(298, 33, 108, 23, NULL, 'kafestánek', NULL, '2016-11-24 00:00:00', 1),
(299, 33, 100, 23, NULL, 'kafestánek', NULL, '2016-11-24 00:00:00', 1),
(300, 34, 154, 23, NULL, 'kafestánek', NULL, '2016-11-23 00:00:00', 1),
(301, 34, 131, 23, NULL, 'kafestánek', NULL, '2016-11-23 00:00:00', 1),
(302, 34, 101, 23, NULL, 'kafestánek', NULL, '2016-11-23 00:00:00', 1),
(303, 34, 112, 23, NULL, 'kafestánek', NULL, '2016-11-23 00:00:00', 1),
(304, 34, 157, 23, NULL, 'kafestánek', NULL, '2016-11-23 00:00:00', 1),
(305, 35, 97, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(306, 35, 111, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(307, 35, 133, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(308, 35, 142, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(309, 35, 138, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(310, 35, 106, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(311, 35, 153, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(312, 35, 141, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(313, 35, 123, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(314, 35, 98, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(315, 35, 94, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(316, 35, 154, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(317, 35, 91, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(318, 35, 137, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(319, 35, 104, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(320, 35, 122, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(321, 35, 101, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(322, 35, 96, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(323, 35, 112, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(324, 35, 157, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(325, 35, 105, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(326, 35, 92, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(327, 35, 108, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(328, 35, 100, 2, NULL, NULL, NULL, '2016-11-29 00:00:00', 1),
(329, 36, 123, 28, 25, 'SAF stánek', NULL, '2016-10-26 00:00:00', 1),
(330, 36, 122, 28, 25, 'SAF stánek', NULL, '2016-10-26 00:00:00', 1),
(331, 37, 142, 3, NULL, NULL, 'pax na RM', '2016-10-14 00:00:00', 1),
(332, 37, 138, 3, NULL, NULL, 'pax na RM', '2016-10-14 00:00:00', 1),
(333, 37, 153, 3, NULL, NULL, 'pax na RM', '2016-10-14 00:00:00', 1),
(334, 37, 137, 3, NULL, NULL, 'pax na RM', '2016-10-14 00:00:00', 1),
(335, 37, 101, 3, NULL, NULL, 'pax na RM', '2016-10-14 00:00:00', 1),
(336, 38, 109, 12, NULL, NULL, 'Core Team RM', '2016-10-14 00:00:00', 1),
(337, 38, 131, 12, NULL, NULL, 'Core Team RM', '2016-10-14 00:00:00', 1),
(338, 38, 107, 12, NULL, NULL, 'Core Team RM', '2016-10-14 00:00:00', 1),
(339, 38, 105, 12, NULL, NULL, 'Core Team RM', '2016-10-14 00:00:00', 1),
(340, 39, 109, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(341, 39, 129, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(342, 39, 97, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(343, 39, 111, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(344, 39, 106, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(345, 39, 121, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(346, 39, 141, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(347, 39, 98, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(348, 39, 154, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(349, 39, 104, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(350, 39, 131, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(351, 39, 107, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(352, 39, 157, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(353, 39, 105, 23, 100, 'RM', 'zlaťáky cca 1000', '2016-10-14 00:00:00', 1),
(354, 40, 123, 23, 150, 'RM', 'zlaťáky cca 1500', '2016-10-14 00:00:00', 1),
(355, 40, 91, 23, 150, 'RM', 'zlaťáky cca 1500', '2016-10-14 00:00:00', 1),
(356, 40, 127, 23, 150, 'RM', 'zlaťáky cca 1500', '2016-10-14 00:00:00', 1),
(357, 40, 112, 23, 150, 'RM', 'zlaťáky cca 1500', '2016-10-14 00:00:00', 1),
(358, 40, 92, 23, 150, 'RM', 'zlaťáky cca 1500', '2016-10-14 00:00:00', 1),
(359, 41, 94, 23, 200, 'RM', 'zlaťáky cca 2000', '2016-10-14 00:00:00', 1),
(360, 41, 125, 23, 200, 'RM', 'zlaťáky cca 2000', '2016-10-14 00:00:00', 1),
(361, 41, 122, 23, 200, 'RM', 'zlaťáky cca 2000', '2016-10-14 00:00:00', 1),
(362, 41, 100, 23, 200, 'RM', 'zlaťáky cca 2000', '2016-10-14 00:00:00', 1),
(363, 42, 133, 23, 50, 'RM', 'zlaťáky cca 500', '2016-10-14 00:00:00', 1),
(364, 42, 108, 23, 50, 'RM', 'zlaťáky cca 500', '2016-10-14 00:00:00', 1),
(365, 43, 101, 23, 20, 'RM', 'zlaťáky 185', '2016-10-14 00:00:00', 1),
(366, 44, 109, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(367, 44, 97, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(368, 44, 111, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(369, 44, 133, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(370, 44, 142, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(371, 44, 138, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(372, 44, 130, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(373, 44, 153, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(374, 44, 141, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(375, 44, 123, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(376, 44, 98, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(377, 44, 94, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(378, 44, 125, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(379, 44, 154, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(380, 44, 91, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(381, 44, 137, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(382, 44, 127, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(383, 44, 104, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(384, 44, 131, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(385, 44, 101, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(386, 44, 132, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(387, 44, 107, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(388, 44, 96, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(389, 44, 112, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(390, 44, 159, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(391, 44, 105, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(392, 44, 92, 2, NULL, NULL, NULL, '2016-11-15 00:00:00', 1),
(393, 45, 92, 30, NULL, NULL, 'Veronika', '2016-10-24 00:00:00', 1),
(394, 46, 92, 30, NULL, NULL, 'Martin Koliba', '2016-10-24 00:00:00', 1),
(395, 47, 92, 30, NULL, NULL, 'Vendula Hájková', '2016-10-24 00:00:00', 1),
(396, 48, 127, 30, NULL, NULL, 'Adam Hercl', '2016-10-27 00:00:00', 1),
(397, 49, 127, 30, NULL, NULL, 'Zbynek Skoda', '2016-11-16 00:00:00', 1),
(398, 50, 127, 30, NULL, NULL, 'Jakub Krempaský', '2016-12-05 00:00:00', 1),
(399, 51, 100, 30, NULL, NULL, 'Alex', '2016-12-06 00:00:00', 1),
(400, 52, 92, 30, NULL, NULL, 'Vašek Šísl', '2016-12-06 00:00:00', 1),
(401, 53, 153, 34, NULL, 'PR meeting', NULL, '2016-12-07 00:00:00', 1),
(402, 53, 141, 34, NULL, 'PR meeting', NULL, '2016-12-07 00:00:00', 1),
(403, 53, 94, 34, NULL, 'PR meeting', NULL, '2016-12-07 00:00:00', 1),
(404, 53, 131, 34, NULL, 'PR meeting', NULL, '2016-12-07 00:00:00', 1),
(405, 53, 112, 34, NULL, 'PR meeting', NULL, '2016-12-07 00:00:00', 1),
(406, 53, 108, 34, NULL, 'PR meeting', NULL, '2016-12-07 00:00:00', 1),
(407, 54, 109, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(408, 55, 109, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(409, 55, 111, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(410, 55, 133, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(411, 55, 142, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(412, 55, 138, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(413, 55, 130, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(414, 55, 153, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(415, 55, 141, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(416, 55, 123, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(417, 55, 98, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(418, 55, 94, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(419, 55, 91, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(420, 55, 127, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(421, 55, 104, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(422, 55, 122, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(423, 55, 101, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(424, 55, 131, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(425, 55, 107, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(426, 55, 96, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(427, 55, 112, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(428, 55, 157, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(429, 55, 92, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(430, 55, 105, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(431, 55, 108, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(432, 55, 100, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(433, 56, 111, 13, NULL, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(434, 56, 133, 13, NULL, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(435, 56, 153, 13, NULL, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(436, 56, 125, 13, NULL, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(437, 56, 137, 13, NULL, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(438, 56, 105, 13, NULL, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(439, 57, 135, 2, NULL, NULL, NULL, '2016-12-13 00:00:00', 1),
(440, 58, 97, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(441, 58, 138, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(442, 58, 135, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(443, 58, 130, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(444, 58, 141, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(445, 58, 123, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(446, 58, 127, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(447, 58, 122, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(448, 58, 131, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(449, 58, 157, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(450, 58, 100, 23, 50, NULL, 'Hack Day', '2016-12-06 00:00:00', 1),
(453, 59, 135, 11, NULL, 'MO - Vánoční večírek', NULL, '2016-12-20 00:00:00', 1),
(454, 60, 111, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(455, 60, 133, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(456, 60, 142, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(457, 60, 138, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(458, 60, 135, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(459, 60, 94, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(460, 60, 125, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(461, 60, 91, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(462, 60, 137, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(463, 60, 131, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(464, 60, 96, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(465, 60, 112, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(466, 60, 157, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(467, 60, 105, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(468, 60, 92, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(469, 60, 108, 2, NULL, NULL, NULL, '2017-01-10 00:00:00', 1),
(475, 62, 92, 28, 10, 'Kodeni mrkvi', NULL, '2017-02-08 00:00:00', 1),
(479, 63, 108, 2, 2, 'účast na LM', NULL, '2017-02-08 00:00:00', 1),
(480, 64, 108, 28, 1, 'debugování Vojtasova kódu', NULL, '2017-02-07 00:00:00', 1),
(481, 65, 104, 28, 2, 'učast na LM', NULL, '2017-02-09 00:00:00', 1),
(483, 67, 153, 2, 2, 'LMko', 'dvě člověkohodiny', NULL, 1),
(484, 68, 153, 34, 2, 'Kurz mítink', 'vedení kurz mítinku', '2017-02-09 00:00:00', 1),
(486, 70, 127, 2, 3, 'LM a DSSS', 'Zápis na DSSS\nÚčast na LM a DSSS\nBichování na LM', '2017-02-11 00:00:00', 1),
(487, 71, 97, 28, 2, 'účast na LM', NULL, '2017-02-11 00:00:00', 1),
(488, 72, 97, 28, 2, 'kurz meeting', NULL, '2017-02-11 00:00:00', 1),
(489, 73, 127, 28, 0, 'Přeprava plakátu na karlák', 'Jen tak pro záznam. Chybí mi tu příloha na selfí s plakátem.', '2017-02-11 00:00:00', 1),
(490, 74, 97, 28, 1, 'Škoda - exkurze', 'mailování', '2017-02-11 00:00:00', 1),
(492, 76, 127, 24, 5, 'Průvodce Prahou', 'Provedl jsem Prahou dvě slečny ze Lvova (UA). Popil pivo a dělal jim odpoledne a večer společnost. Sehnal i Use-it mapy. A sdělil jim pár zajímavostním k památkám.', '2017-02-11 00:00:00', 1),
(493, 77, 153, 28, 1, 'PR meeting', 'účast', '2017-02-14 00:00:00', 1),
(494, 78, 108, 34, 2, 'účast na SuC meetingu', NULL, '2017-02-09 00:00:00', 1),
(495, 79, 122, 28, 3, 'DSSS & LM', NULL, '2017-02-08 00:00:00', 1),
(496, 80, 135, 28, 1, 'PR meeting', NULL, '2017-02-21 00:00:00', 1),
(499, 83, 108, 28, 3, 'DSSS + LM', NULL, '2017-02-21 00:00:00', 1),
(500, 84, 104, 28, 3, 'DSSS+LM', NULL, '2017-02-26 00:00:00', 1),
(501, 85, 104, 28, 2, 'BM', NULL, '2017-02-26 00:00:00', 1);

-- --------------------------------------------------------

--
-- Struktura tabulky `members_rank`
--

CREATE TABLE IF NOT EXISTS `members_rank` (
  `id_rank` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `voting_right` tinyint(1) DEFAULT NULL,
  `access_right` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`id_rank`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Vypisuji data pro tabulku `members_rank`
--

INSERT INTO `members_rank` (`id_rank`, `name`, `voting_right`, `access_right`, `active`) VALUES
(1, 'Observer', 0, 0, 1),
(2, 'Baby member', 0, 1, 1),
(3, 'Full member', 1, 1, 1),
(4, 'Boardie', 1, 1, 1),
(5, 'Alumni', 0, 0, 0),
(6, 'Distanční člen', 0, 1, 0),
(7, 'Neaktivní', 0, 0, 0);

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `members_board_pos`
--
ALTER TABLE `members_board_pos`
  ADD CONSTRAINT `fk_members_board_pos_members_member1` FOREIGN KEY (`id_member`) REFERENCES `members_member` (`id_member`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Omezení pro tabulku `members_member`
--
ALTER TABLE `members_member`
  ADD CONSTRAINT `fk_members_member_members_member1` FOREIGN KEY (`id_angel`) REFERENCES `members_member` (`id_member`) ON DELETE NO ACTION,
  ADD CONSTRAINT `fk_members_member_members_rank1` FOREIGN KEY (`id_rank`) REFERENCES `members_rank` (`id_rank`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Omezení pro tabulku `members_points`
--
ALTER TABLE `members_points`
  ADD CONSTRAINT `members_points_ibfk_1` FOREIGN KEY (`id_member`) REFERENCES `members_member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_activity_2` FOREIGN KEY (`id_activity`) REFERENCES `members_activities` (`id_activity`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
