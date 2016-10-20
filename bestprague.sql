-- phpMyAdmin SQL Dump
-- version 4.0.10.12
-- http://www.phpmyadmin.net
--
-- Počítač: localhost:3309
-- Vygenerováno: Čtv 20. říj 2016, 17:13
-- Verze serveru: 5.1.73-14.12-log
-- Verze PHP: 5.5.9-1ubuntu4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bestprague`
--

-- --------------------------------------------------------

--
-- Table structure for table `members_board_pos`
--

DROP TABLE IF EXISTS `members_board_pos`;
CREATE TABLE IF NOT EXISTS `members_board_pos` (
  `id_board_pos` int(11) NOT NULL AUTO_INCREMENT,
  `id_member` int(11) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `executive` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_board_pos`),
  KEY `fk_members_board_pos_members_member1_idx` (`id_member`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `members_board_pos`
--

INSERT INTO `members_board_pos` (`id_board_pos`, `id_member`, `name`, `executive`) VALUES
(1, 101, 'President', 1),
(2, 94, 'VP for PR', 1),
(3, 92, 'VP for HR', 1),
(4, 91, 'VP for CR', 1),
(5, 104, 'Secretary', 1),
(6, NULL, 'Treasurer', 1),
(7, 98, 'Vivaldi Responsible', 0),
(8, 142, 'IT Coordinator', 0);

-- --------------------------------------------------------

--
-- Table structure for table `members_member`
--

DROP TABLE IF EXISTS `members_member`;
CREATE TABLE IF NOT EXISTS `members_member` (
  `id_member` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `nickname` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `joined` date DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
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
  `image` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_member`),
  KEY `fk_members_member_members_rank1_idx` (`id_rank`),
  KEY `fk_members_member_members_member1_idx` (`id_angel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=154 ;

--
-- Dumping data for table `members_member`
--

INSERT INTO `members_member` (`id_member`, `name`, `surname`, `nickname`, `email`, `joined`, `active`, `wg`, `id_rank`, `id_angel`, `telephone`, `fb`, `skype`, `erasmus`, `tshirt`, `role`, `gender`, `google_id`, `image`) VALUES
(70, 'Alena', 'Juklová', NULL, 'alena.juklova@gmail.com', '2010-02-01', 0, NULL, 5, NULL, '+420721981325', NULL, NULL, NULL, 'S/M', 'member', 'F', NULL, NULL),
(71, 'Alena', 'Nimrichtrová', 'Ála', 'animrichtrova@gmail.com', '2012-11-01', 0, NULL, 5, NULL, '+420732555479', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(72, 'Anna', 'Doncheva', NULL, 'anna.m.doncheva@gmail.com', '2009-09-04', 0, NULL, 5, NULL, '+420776672799', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(73, 'Edita', 'Dvořáková', NULL, 'edita.dvo@gmail.com', '2012-05-01', 0, NULL, 5, NULL, '+420739037799', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(74, 'Jaroslav', 'Hrubý', NULL, 'profik@spk.cz', '2010-10-01', 0, NULL, 5, NULL, '+420777746117', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(75, 'Jaroslav', 'Marek', NULL, 'maslic@gmail.com', '2008-07-01', 0, NULL, 5, NULL, '+420605296306', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(76, 'Jiri', 'Kotlan', NULL, 'kotlan.jiri@centrum.cz', '2012-05-01', 0, NULL, 5, NULL, '+420777810535', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(77, 'Karel', 'Šimek', NULL, 'karelsurfer@googlemail.com', '2009-07-01', 0, NULL, 5, NULL, '+420776554737', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(78, 'Kateřina', 'Indrová', NULL, 'indrova.katka@gmail.com', '2011-04-01', 0, NULL, 5, NULL, '+420777676233', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(79, 'Lucie', 'Buzková', NULL, 'lucka.buzkova@gmail.com', '2012-10-28', 0, NULL, 5, NULL, '+420728401211', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(80, 'Marek', 'Pesta', NULL, 'marekpesta@gmail.com', '2011-10-01', 0, NULL, 5, NULL, '+420724371322', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(81, 'Marketa', 'Hildebrandtová', NULL, 'marketa@hildebrandtova.cz', '2010-09-01', 0, NULL, 5, NULL, '+420731637173', NULL, NULL, NULL, 'S', 'member', 'F', NULL, NULL),
(82, 'Michal', 'Čáp', NULL, 'michal.cap@email.cz', '2010-11-01', 0, NULL, 5, NULL, '+420774227466', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(83, 'Michal', 'Šustr', NULL, 'michal.sustr@gmail.com', '2012-06-01', 0, NULL, 5, NULL, '+420734601300', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(84, 'Petr', 'Kopecký', NULL, 'peta.kopecky@gmail.com', '2011-09-01', 0, NULL, 5, NULL, '+420723748569', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(85, 'Petr', 'Vála', NULL, 'petr.m.vala@gmail.com', '2012-01-01', 0, NULL, 5, NULL, '+420723888512', NULL, 'petr..vala', NULL, NULL, 'member', 'M', NULL, NULL),
(86, 'Ramona', 'Sanigová', NULL, 'ramushka@gmail.com', '2011-09-01', 0, NULL, 5, NULL, '+420736425023', NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(87, 'Zdenek', 'Pecka', NULL, 'peckazde@gmail.com', '2012-05-01', 0, NULL, 5, NULL, '+420731002695', 'https://www.facebook.com/peckazde?fref=ts', 'peckazde', NULL, NULL, 'member', 'M', NULL, NULL),
(88, 'Šárka', 'Dragounová', NULL, 'sarkadrag@gmail.com', '2010-10-01', 0, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(89, 'Adam', 'Uhlíř', NULL, 'uhlir.a@gmail.com', '2012-05-01', 0, NULL, 5, 127, '+420607963319', 'https://www.facebook.com/uhlir.a?fref=ts', 'uhlir.a', NULL, 'L', 'member', 'M', NULL, NULL),
(90, 'Gabriela', 'Kadlecová', NULL, 'kadlecova.g@gmail.com', '2012-05-01', 0, NULL, 5, 74, '+420605713607', 'https://www.facebook.com/gabrielak1?ref=ts&fref=ts', 'gabasek77', NULL, 'M', 'member', 'F', NULL, NULL),
(91, 'Martin', 'Růžička', 'Martins', 'martinr.mr@gmail.com', '2014-07-30', 1, 'CR', 4, 134, '+420777312393', 'https://www.facebook.com/martin.ruzicka.37051?fref=ts', NULL, NULL, 'M', 'admin', 'M', '115779569032645361215', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(92, 'Vojta', 'Dlápal', 'Vojtas', 'sadlomasloskvarky@gmail.com', '2014-10-30', 1, 'CR', 4, 134, '+420606357714', 'https://www.facebook.com/vojta.dlapal', 'sadlomasloskvarky', NULL, 'M', 'admin', 'M', '116806164621879767628', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(93, 'Aneta', 'Šnellerová', NULL, 'aneta.snellerova@gmail.com', '2015-11-27', 0, 'PR', 6, 131, '+420732581541', 'https://www.facebook.com/aneta.snellerova?fref=ts', NULL, NULL, NULL, 'member', 'F', '101798190882923449757', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(94, 'Kateřina', 'Holetová', NULL, 'kat.holetova@gmail.com', '2015-04-30', 1, 'PR', 4, 130, '+420774367442', 'https://www.facebook.com/kata.holetova?fref=ts', NULL, NULL, 'M', 'admin', 'F', '103919265445912663102', 'https://lh4.googleusercontent.com/-58bB0NuaWzg/AAAAAAAAAAI/AAAAAAAAAEM/9lwD2LrwedE/photo.jpg'),
(95, 'Radka', 'Vopatová', NULL, 'vopatova.radka@gmail.com', '2015-07-07', 1, 'PR', 2, 108, '+420776587305', 'https://www.facebook.com/vopatrad?fref=ts', NULL, NULL, 'M', 'member', 'F', '102096720175391167082', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(96, 'Tomáš', 'Jelínek', 'Jelen', 'tomas.jelinek.91@gmail.com', '2015-11-26', 1, 'PR', 3, 127, '+420605720748', 'https://www.facebook.com/tomas.jelinek.56?fref=ts', NULL, NULL, 'XXL', 'member', 'M', '115206372649878937308', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(97, 'Bui Phu', 'Hai', 'Haiß', 'buiphuhai91@gmail.com', '2015-11-10', 1, 'CR', 3, 106, '+420608738308', 'https://www.facebook.com/buiphuhai', NULL, NULL, 'M', 'member', 'M', '112197486509364422177', 'https://lh6.googleusercontent.com/-Pyexwq1aBbU/AAAAAAAAAAI/AAAAAAAAArw/s2GRHB6b2lA/photo.jpg'),
(98, 'Karolína', 'Berková', NULL, 'karol.berkova@gmail.com', '2015-10-30', 1, 'HR', 4, 105, '+420722198716', NULL, NULL, NULL, 'M', 'admin', 'F', '107496236023293841145', 'https://lh3.googleusercontent.com/-Eiy977JHzVk/AAAAAAAAAAI/AAAAAAAAAKQ/5vQuRrrmut8/photo.jpg'),
(99, 'Jan', 'Orihel', NULL, 'jan.orihel7@gmail.com', '2014-10-27', 0, 'CR', 6, 126, '+420602745050', NULL, NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(100, 'Zdeněk', 'Šlégl', 'Zdeněks', 'zdenek.slegl@gmail.com', '2014-10-28', 0, 'CR', 2, 128, '+420728977929', 'https://www.facebook.com/zdenek.slegl', NULL, NULL, 'L', 'member', 'M', NULL, NULL),
(101, 'Petr', 'Jirásko', 'Jitr', 'jiraspe2@gmail.com', '2014-10-30', 1, 'PR', 4, 122, '+420723413160', 'https://www.facebook.com/petr.jirasko.7', NULL, NULL, 'L', 'admin', 'M', '111340492575035657377', 'https://lh4.googleusercontent.com/-m0nkESRKkT4/AAAAAAAAAAI/AAAAAAAAAEA/nkFAOGEO5-Q/photo.jpg'),
(102, 'Martin', 'Svatoš', NULL, 'martinsvat@gmail.com', NULL, 0, 'PR', 6, 134, '+420721331022', 'https://www.facebook.com/e1b4574rd0?fref=ts', NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(103, 'Lucie', 'Marcalíková', NULL, 'luciemarcalikova@gmail.com', '2015-11-01', 1, 'HR', 2, 125, '+420732131321', 'https://www.facebook.com/profile.php?id=100005009568726&fref=ts', NULL, NULL, 'S', 'member', 'F', '112555173739173030993', 'https://lh3.googleusercontent.com/-ClnkurWGLRM/AAAAAAAAAAI/AAAAAAAAAIk/e9qEtvSR9zY/photo.jpg'),
(104, 'Nicola', 'Kyjevská', NULL, 'kyjevska.nicol@gmail.com ', '2015-10-01', 1, NULL, 4, 133, '+420728599260', 'https://www.facebook.com/nicola.kyjevska', NULL, NULL, 'M', 'admin', 'F', '106518781665734565246', 'https://lh6.googleusercontent.com/-Lpw0u6vIkdw/AAAAAAAAAAI/AAAAAAAAAO8/M2bQlIirHnQ/photo.jpg'),
(105, 'Vojta', 'Hájek', 'Kojtas', 'hajek.vojtech@gmail.com', '2015-07-10', 1, 'CR', 3, 107, '+420733543482', 'https://www.facebook.com/hajek.vojtech?ref=ts&fref=ts', NULL, NULL, 'M', 'admin', 'M', '109242322011176480194', 'https://lh5.googleusercontent.com/-TKa0GzJJkfk/AAAAAAAAAAI/AAAAAAAAAEI/YSfBCEKFegA/photo.jpg'),
(106, 'Hana', 'Morávková', NULL, 'Hana.moravkova611@gmail.com', '2015-04-30', 1, NULL, 3, 132, '+420607706773', 'https://www.facebook.com/moravkova.hana?fref=ts', NULL, NULL, 'S', 'admin', 'F', '112596474200990034579', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(107, 'Sylvie', 'Horváthová', NULL, 'sylvinkyhtc@gmail.com', '2014-10-30', 1, 'PR', 3, 89, '+420737184376', 'https://www.facebook.com/sylvie.horvathova', 'sylwana_from_cz', NULL, 'L', 'admin', 'F', '107056950087460792329', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(108, 'Zdeněk', 'Kasner', NULL, 'zdenek.kasner@gmail.com', '2014-10-10', 1, 'PR', 3, 124, '+420721824283', 'https://www.facebook.com/zdenek.kasner', NULL, NULL, 'L', 'admin', 'M', '118335767426874674196', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(109, 'Adam', 'Kučera', 'Adams', 'wrent00@gmail.com', '2012-09-20', 1, 'CR', 3, 70, '+420608921904', 'https://www.facebook.com/Wrent00?fref=ts', 'wrent00', NULL, 'L', 'admin', 'M', '115043252509922068003', 'https://lh6.googleusercontent.com/-2oAc1zjbzGA/AAAAAAAAAAI/AAAAAAAAYwo/l14bgs5sOTE/photo.jpg'),
(110, 'Petra', 'Martišková', NULL, 'martiskova.p@seznam.cz', '2014-10-30', 1, NULL, 3, 125, '+420724171423', 'https://www.facebook.com/petra.martiskova.3', NULL, NULL, 'M', 'admin', 'F', '103665471938817608909', 'https://lh5.googleusercontent.com/-9N8QLYNH0BM/AAAAAAAAAAI/AAAAAAAAABM/aOWNn5zGyf4/photo.jpg'),
(111, 'Dalibor', 'Pospíšil', NULL, 'pospisil.dalibor@gmail.com', '2014-10-28', 1, NULL, 3, 124, '+886905611179', 'https://www.facebook.com/dalibor.pospisil.1?fref=ts', NULL, NULL, 'M', 'member', 'M', '101108101519143059859', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(112, 'Vašek', 'Michalec', NULL, 'vaclav.michalec@gmail.com', '2015-04-30', 1, 'HR', 3, 123, '+420605174943', 'https://www.facebook.com/vasek.michalec?fref=ts', NULL, NULL, 'L', 'admin', 'M', '102676211932994450687', 'https://lh4.googleusercontent.com/-eFfq3nDymJw/AAAAAAAAAAI/AAAAAAAAAD4/2ZM98CKKBJs/photo.jpg'),
(113, 'Martina', 'Češková', NULL, ' martina.ceskova@gmail.com', NULL, 0, NULL, 6, 126, '+420605981671', 'https://www.facebook.com/ceskova.martina?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(114, 'Maťo', 'Koyš', NULL, 'mato.koys01@gmail.com', NULL, 0, NULL, 6, 124, '+420607688562', 'https://www.facebook.com/mato.koys?fref=ts', NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(115, 'Mirka', 'Blahutová', NULL, 'blahutovamirka@gmail.com', NULL, 0, NULL, 6, NULL, '+420732709309', 'https://www.facebook.com/Jahoodka69?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(116, 'Simona', 'Strnadová', NULL, 'strnadova.simi@gmail.com', NULL, 0, NULL, 6, NULL, '+420728003523', 'https://www.facebook.com/slunicko?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(117, 'Violetta', 'Ladukayte', NULL, 'violetta.ladukayte@gmail.com', '2012-05-01', 0, 'HR', 6, 86, '+420608831070', 'https://www.facebook.com/violetta.ladukayte?fref=ts', 'violetta489', NULL, 'S', 'member', 'F', NULL, NULL),
(118, 'Jan', 'Fojt', NULL, 'john.generix@gmail.com', NULL, 0, NULL, 5, NULL, '+420603891957', 'https://www.facebook.com/honzik.fojt?fref=ts', NULL, NULL, 'L', 'member', 'M', NULL, NULL),
(119, 'Adam', 'Kozel', NULL, 'adamkozel.aust@gmail.com', NULL, 0, NULL, 6, NULL, '+420728915553', 'https://www.facebook.com/adam.kozel.3?fref=ts', NULL, NULL, NULL, 'member', 'M', NULL, NULL),
(120, 'Angelika', 'Pruchová', NULL, 'angelika.pruchova@gmail.com', NULL, 0, NULL, 6, NULL, '+420777302080', 'https://www.facebook.com/angi.pruchova?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(121, 'Jaroslav', 'Hanák', NULL, 'jaroslavhanak42@gmail.com', '2014-10-27', 1, 'CR', 3, 126, '+420739040359', 'https://www.facebook.com/Jarda.Hanak', NULL, NULL, 'L', 'member', 'M', '107762697795411302071', 'https://lh6.googleusercontent.com/-SPnX5-zfiYU/AAAAAAAAAAI/AAAAAAAAABE/pITT2TiUjG8/photo.jpg'),
(122, 'Pavlína', 'Nykodémová', NULL, 'pavlina.nykodemova@gmail.com', '2014-02-28', 1, 'HR', 3, 120, '+420721537149', 'https://www.facebook.com/pavlina.nykodemova?fref=ts', NULL, NULL, 'M', 'member', 'F', '101179032596618482913', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(123, 'Jitka', 'Jeníková', NULL, 'jenikova.jitka.jj@gmail.com', '2014-04-27', 1, 'HR', 3, 131, '+420736455800', 'https://www.facebook.com/jitka.jenikova.3?fref=ts', NULL, NULL, 'XL', 'member', 'F', '107106448913838860048', 'https://lh6.googleusercontent.com/-L6M_oIhPeig/AAAAAAAAAAI/AAAAAAAAAGY/fCyZ-ZRNbuI/photo.jpg'),
(124, 'Lucka', 'Linderová', NULL, 'lucie.linderova@gmail.com', '2013-05-20', 1, 'HR', 3, 79, '+420739524666', 'https://www.facebook.com/lucka.linderova?fref=ts', NULL, NULL, 'M', 'member', 'F', '115843542211774093324', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(125, 'Lukáš', 'Vondra', NULL, 'vondra.ctu@gmail.com', '2012-10-28', 1, 'PR', 3, 73, '+420605967315', 'https://www.facebook.com/lukas.vondra.1?fref=ts', NULL, NULL, 'L', 'member', 'M', '101818670828374517650', 'https://lh5.googleusercontent.com/-iaENO-MptLc/AAAAAAAAAAI/AAAAAAAAAG4/bCmP8wa2fPU/photo.jpg'),
(126, 'Tomáš', 'Budil', 'Tomášs', 'mr.pheb@gmail.com', '2013-02-09', 1, 'CR', 5, 71, '+420731283550', 'https://www.facebook.com/tbudil?fref=ts', 'phebbb', NULL, 'L', 'member', 'M', '116585273808105931090', 'https://lh4.googleusercontent.com/-bUN1GBhTknI/AAAAAAAAAAI/AAAAAAAAAB0/z6dA-R_A9i0/photo.jpg'),
(127, 'Milan', 'Poláček', NULL, 'polacek.emilan@gmail.com', '2011-10-31', 1, 'HR', 3, 88, '+420605733249', 'https://www.facebook.com/Mr.Milan.Polacek', 'Milan_von_Teuflice', NULL, 'L', 'member', 'M', '110900917130374653576', 'https://lh4.googleusercontent.com/-DNF5hZ0x-Xw/AAAAAAAAAAI/AAAAAAAAAKo/QAxSIeDJUq0/photo.jpg'),
(128, 'Andrea', 'Schejbalová', 'Andy', 'schejbalova.andrejka@gmail.com', '2013-09-01', 1, NULL, 3, 89, '+420608878840', 'https://www.facebook.com/aschejbalova?fref=ts', 'andreejka8', NULL, 'M', 'member', 'F', NULL, NULL),
(129, 'Barča', 'Drahorádová', NULL, 'drahoradova.barca@gmail.com', '2013-05-03', 1, 'HR', 3, 109, '+420602940537', 'https://www.facebook.com/drahoradova.barca?fref=ts', 'beruska_barca', NULL, 'M', 'member', 'F', '106274892394054240186', 'https://lh3.googleusercontent.com/-6HmZcPmERvg/AAAAAAAAAAI/AAAAAAAAB-w/QSrO1-FsRd4/photo.jpg'),
(130, 'Honza', 'Předota', 'Předotas', 'predota.honza@gmail.com', '2014-10-03', 1, 'CR', 3, 129, '+420728448266', 'https://www.facebook.com/jan.predota', 'honpre', NULL, 'M', 'member', 'M', '115792857557759094183', 'https://lh4.googleusercontent.com/-UYL3Z1BNK3g/AAAAAAAAAAI/AAAAAAAAAF8/qBuggYvK5k0/photo.jpg'),
(131, 'Petr', 'Jarušek', 'Jetter', 'petrjarusek@gmail.com', '2013-09-01', 1, 'PR', 3, 124, '+420608338317', 'https://www.facebook.com/petrjarusek?fref=ts', NULL, NULL, 'L', 'member', 'M', '107561164286174176014', 'https://lh4.googleusercontent.com/-cBkIGn104yk/AAAAAAAAAAI/AAAAAAAABYY/kAPFXVZRQ1Q/photo.jpg'),
(132, 'Petr', 'Novák', 'Speedy', 'netr.povak@gmail.com', '2013-10-01', 1, NULL, 3, 117, '+420776009727', 'https://www.facebook.com/petr.s.novak?fref=ts', 'D.evil_Speedy', NULL, 'M', 'member', 'M', '110024337337010848371', 'https://lh4.googleusercontent.com/-C1qD3HnCLus/AAAAAAAAAAI/AAAAAAAAAF8/2FvxyfLXEoM/photo.jpg'),
(133, 'David', 'Příhoda', NULL, 'david.prihoda@gmail.com', '2013-02-01', 1, 'HR', 3, 89, '+420728921350', 'https://www.facebook.com/d.prihoda?fref=ts', NULL, NULL, 'XL', 'admin', 'M', '117837490822947964582', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(134, 'Víťa', 'Štván', 'Víťas', 'v.stvan@gmail.com', NULL, 0, 'CR', 5, 109, '+420608051908', 'https://www.facebook.com/vita.stvan?fref=ts', 'kouzelnik.v', NULL, 'L', 'member', 'M', '104426860468081989026', 'https://lh5.googleusercontent.com/-IiL4xDmtUE8/AAAAAAAAAAI/AAAAAAAAAxw/xSKa1VOUihc/photo.jpg'),
(135, 'Heda', 'Jakubův', NULL, 'heda.jakubuv@gmail.com', '2015-12-23', 1, 'HR', 2, 112, '+420723175261', 'https://www.facebook.com/Hedus', NULL, NULL, 'XS-S', 'member', 'F', '112719324614896759018', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(136, 'Honza', 'Dobeš', '', 'honnzad@gmail.com', NULL, 1, '', 1, 111, '', 'https://www.facebook.com/jan.dobes1?fref=pb_other', NULL, NULL, '', 'member', 'M', NULL, NULL),
(137, 'Michal', 'Kocánek', 'Hřebeček', 'kocanek.m@gmail.com', '2016-02-23', 1, 'CR', 2, 107, '+420728658501', 'https://www.facebook.com/michal.kocanek', NULL, NULL, 'M', 'member', 'M', '117728965119177100240', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(138, 'František', 'Nekovář', 'Frodos', 'fnekovar@gmail.com', '2016-02-23', 1, 'PR', 2, 109, '+420773691550', 'https://www.facebook.com/frantisek.nekovar', NULL, NULL, 'L', 'member', 'M', '115717313891738095667', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(141, 'Jirka', 'Vastl', NULL, 'wastlik1@gmail.com', '2016-03-26', 1, 'HR', 2, 129, '+420723311326', 'https://www.facebook.com/jirka.vastl', NULL, NULL, 'M', 'member', 'M', '112452133550939299517', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'),
(142, 'David', 'Janoušek', NULL, 'edavidjanousek@gmail.com', '2016-04-30', 1, 'PR', 4, 94, '+420730571844', 'https://www.facebook.com/profile.php?id=100011464778172&fref=ts', NULL, NULL, NULL, 'admin', 'M', '106558671216957130665', 'https://lh3.googleusercontent.com/-FFWN1pieA2E/AAAAAAAAAAI/AAAAAAAAAMg/1wwOHMp47S8/photo.jpg'),
(143, 'Martina', 'Vaněčková', NULL, 'vaneckova.marti@gmail.com', '2016-04-23', 1, NULL, 1, 112, '+420777171898', 'https://www.facebook.com/martina.p.vaneckova', NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(151, 'Klaudie', 'Hristova', NULL, 'k.hristova@seznam.cz', '2016-05-08', 1, NULL, 1, 91, NULL, 'https://www.facebook.com/rikiki?fref=ts', NULL, NULL, NULL, 'member', 'F', NULL, NULL),
(152, 'Tereza', 'Vacková', NULL, 'vackovat@gmail.com', '2016-04-30', 1, NULL, 1, NULL, '+420737058717', 'https://www.facebook.com/tereza.vackova.71?fref=ts', NULL, NULL, NULL, 'member', 'F', '116235436102644137236', 'https://lh6.googleusercontent.com/-WR1-dH5-XkE/AAAAAAAAAAI/AAAAAAAAAB0/4tHbCX7kUww/photo.jpg'),
(153, 'Jan', 'Špale', NULL, 'jan.spale96@gmail.com', '2016-07-09', 1, NULL, 2, 112, '+420723414693', 'https://www.facebook.com/jan.spale', NULL, NULL, 'L', 'member', 'M', '114567847985079308733', 'https://lh4.googleusercontent.com/-T3AUiGBjLps/AAAAAAAAAAI/AAAAAAAAAFw/WwoT3saahkw/photo.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `members_rank`
--

DROP TABLE IF EXISTS `members_rank`;
CREATE TABLE IF NOT EXISTS `members_rank` (
  `id_rank` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `voting_right` tinyint(1) DEFAULT NULL,
  `access_right` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`id_rank`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `members_rank`
--

INSERT INTO `members_rank` (`id_rank`, `name`, `voting_right`, `access_right`, `active`) VALUES
(1, 'Observer', 0, 1, 1),
(2, 'Baby member', 0, 1, 1),
(3, 'Full member', 1, 1, 1),
(4, 'Boardie', 1, 1, 1),
(5, 'Alumni', 0, 0, 0),
(6, 'Distanční člen', 0, 1, 0),
(7, 'Neaktivní', 0, 0, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `members_board_pos`
--
ALTER TABLE `members_board_pos`
  ADD CONSTRAINT `fk_members_board_pos_members_member1` FOREIGN KEY (`id_member`) REFERENCES `members_member` (`id_member`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `members_member`
--
ALTER TABLE `members_member`
  ADD CONSTRAINT `fk_members_member_members_member1` FOREIGN KEY (`id_angel`) REFERENCES `members_member` (`id_member`) ON DELETE NO ACTION,
  ADD CONSTRAINT `fk_members_member_members_rank1` FOREIGN KEY (`id_rank`) REFERENCES `members_rank` (`id_rank`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
