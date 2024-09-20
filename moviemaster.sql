-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 20/09/2024 às 20:37
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `moviemaster`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `credenciais`
--

CREATE TABLE `credenciais` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `credenciais`
--

INSERT INTO `credenciais` (`id`, `nome`, `email`, `senha`) VALUES
(1, 'teste1234', 'testedhdjdjei', '46070d4bf934fb0d4b06d9e2c46e346944e322444900a435d7d9a95e6d7435f5'),
(2, 'teste12213443', 'teste432234432', '782be85dbdb495156f8fe3ff5005afef53d6c96f9e694dc83d2a58c3a59193d9'),
(3, 'brito', 'guilhfdshfdhs@hfjds', '9ef63e4b62acf2456b0fe4b0db3f3696ea63a69685a3023d36e033cea197142b'),
(4, 'brito', 'guilhfdshfdhs@hfjds', '9ef63e4b62acf2456b0fe4b0db3f3696ea63a69685a3023d36e033cea197142b'),
(5, 'Dhedhdhdd', 'Fdhxhdh@hfjfjd', '0cf07a77fbdfcb6645fe8a4daab68c7b179878e76e28d2d61138a91e2b934fed'),
(6, 'Dhedhdhdd', 'MagoNicolaldo', '0cf07a77fbdfcb6645fe8a4daab68c7b179878e76e28d2d61138a91e2b934fed'),
(7, 'Gui Brito', 'Guilherme@briti', '29649d4224dc16146cd4ef32c19c744e0a224d7e8622f041ba8055f0e998c6db'),
(8, 'Nicolas', 'MagoNicolaldo', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(9, 'Pedro', 'Pedro@gmail.com', 'f7308341937e89daf1140b6c4636e9a33736e187e2250d7b661d1304cad6c4fc'),
(10, 'sdsadasd', 'dsasaasdda', '92f15cbd78bf55ff08079ca4549a64b793ebf372d0193f496d8c72a59d1ce36e'),
(11, 'GuilhermeBrito', 'guilhermesantiagodebrito@gmail.com', 'ebdf496f67651cddf6aaa1f0b130f1b99ce9e2e93dc2503d926edcff15aee668'),
(12, 'Naruto', 'Flamengo', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(13, 'Hdjdjdjdbdb', 'Teesteebsbssb', '7095aed4d14b32ef5e7a9c6bd954506d7593fd3e912b9e3a0d1e1c7d1ebeca95'),
(14, 'brito', 'brito', 'brito'),
(15, 'brito', 'brito', '04e60ff82d01c521c578eec39c415b99512c658feb264ef03cd1a5efdbe893b3'),
(16, 'Brito', 'Brito', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(17, 'brito123ddddddddddddcccccccccccccc', 'flamengosdddddddddddddddsssssss', 'd58d736c7a967fb5f307951932734f8b0594725faa5011dbb66a8c538e635fb6'),
(18, 'aaa', 'aaa', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(19, 'Vermelho', 'goku', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(20, 'punpun', 'nicolas@gmail.com', '81edcda020d618244e9bc2fd65e69cd16e042349d6eba134132b3a4521380b0c'),
(21, 'brito', 'nko@gmail.com', '4b03dcd4a2ad0fd235b38b0ceb7a7bef5b848d5ae63d58fcbec4178b61b3a9e9'),
(22, 'nicolas', 'nicolas@gmail.com', 'd6d34583ad7ff5022ab7bbd5a22798035a69851dd69676d9bca708baf0c967b3'),
(23, 'Brito', 'Guilherme@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(24, 'Gigi', 'giovanna@gmail.com', 'ee79976c9380d5e337fc1c095ece8c8f22f91f306ceeb161fa51fecede2c4ba1'),
(25, 'pedro', 'pedro@ph.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(26, 'nicolas', 'nicolas@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(27, 'nicolas', 'nicolas@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(28, 'jesus', 'nicolas@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(29, 'brito', 'guilherme@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(30, 'Lixo', 'Lixo@hotmail.com', '27e207653fbc09a0c4efa7671e3e6ed02ec74dde0990485c221dd4f1f2bbd0ca'),
(31, 'lixo@hotmail.com', 'Lixo@hotmail.com', '27e207653fbc09a0c4efa7671e3e6ed02ec74dde0990485c221dd4f1f2bbd0ca'),
(32, 'lixo@hotmail.com', 'Lixo@hotmail.com', '27e207653fbc09a0c4efa7671e3e6ed02ec74dde0990485c221dd4f1f2bbd0ca'),
(33, 'lixo@hotmail.com', 'Lixo@hotmail.com', '27e207653fbc09a0c4efa7671e3e6ed02ec74dde0990485c221dd4f1f2bbd0ca'),
(34, 'lixo@hotmail.com', 'Lixo@hotmail.com', '27e207653fbc09a0c4efa7671e3e6ed02ec74dde0990485c221dd4f1f2bbd0ca'),
(35, 'lixo@hotmail.com', 'Lixo@hotmail.com', '27e207653fbc09a0c4efa7671e3e6ed02ec74dde0990485c221dd4f1f2bbd0ca'),
(36, 'Ribas', 'Ribamar@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(37, 'Joao Pedro', 'joaopedro@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(38, 'mate', 'matheuz@diniz', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(39, 'nicoldsajhdasfsadsda', 'nicolasdasdasdas', 'e7fb758c35972aecfa9755c1cd7609704ca31f570d1638f0ce9a8298a689d595'),
(40, 'fadfdafaffaf', 'fsaadffsfsafas', '1ed8480c7407e040dd63e3905c019ed657ca094201b67ad88e939cd7b5fbb107'),
(41, 'asfassafasfs', 'sadadfafsjfasfass', '8fa4388e27cecebd0c30bfc51420ff6cfbaedf3d43ddf53721668ac048920a91'),
(42, 'asffsaffasf', 'sadffsf', '29cd2b8412e67d1878c3e841647e6272c216c4bf1d0a2195def7726cf821dcb3'),
(43, 'brito', 'afsj]dgghgshsaddsagh', 'ad7be9c117caee5f5761f2bd20a7faf65d85d1cf8d0e6996a09e87db80ce34ad'),
(44, 'sdvkuhfdigfhuçsfjoi', 'dfsiohegtdohzodhdgzhu', '4aa7d9d6bd7fbfdfc5e81eddf4cdb17c2a4ab3689e33837b21737862a457e7af'),
(45, 'TONO', 'ANABANANA@GMAIL/COM', '52cbca6a093548ea58aff698c84d415abac4fb52810a03cdec6848ec04d9d59a'),
(46, 'PcGamerBrazil', 'PauloCezar@sesi.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(47, 'PcGamerBrazil', 'PauloCezar@sesi.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(48, 'Brito132', 'BritoFlamengo@gmail.comhhj', '9992594065d5b41a85d8597b69946cb542f0af6f0dfdf8ab9e1d3fc73540cf6c'),
(49, 'Eidhdhshsh', 'Ejdjeheheh', '3e7590dfa462fe2a392793d2ac3f77fdbf2cd1630012da287bd854f8aff6d72b'),
(50, 'britoerroneo', 'brito', 'cecfc6b3859482bb15b81d433114ab5961610bbb651e6803b128914b7b1c989e'),
(51, 'Brito', 'Brito', '021ff940c3bba210e31c2be521e607d23b8335a08a153fe654df1ef63ac7914a'),
(52, 'teste', 'teste@gmail.com', '289160db0d9f39f9ae1754c4ec9c16f90b50e32e09c5fb5481ae642b3d3d1a36'),
(53, 'nicolas', 'nicolas', '0c865679be40dfa82096b955071455b688b505a2bdf792225f96bef4a8a8a99e'),
(54, 'socrates', 'platao', '66318b6ad837b7ab4f2c9ad06eaca468efd3d0b28c7fd53d9ab38fdcfd228f49'),
(55, 'PaulinhoDaViola', 'PcGamerRTXBR@gmail.com', 'e24df920078c3dd4e7e8d2442f00e5c9ab2a231bb3918d65cc50906e49ecaef4'),
(56, 'banquete', 'platao', '710482eaa280e6b7e9ed98958197686ea52772371d2374089e677ff77eae18eb');

-- --------------------------------------------------------

--
-- Estrutura para tabela `curtidas`
--

CREATE TABLE `curtidas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  `data_curtida` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `descurtidas`
--

CREATE TABLE `descurtidas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  `data_curtida` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `filmes`
--

CREATE TABLE `filmes` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `ano_lancamento` year(4) DEFAULT NULL,
  `genero` varchar(100) DEFAULT NULL,
  `data_adicao` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `postagens`
--

CREATE TABLE `postagens` (
  `id` int(11) NOT NULL,
  `credenciais_id` int(11) DEFAULT NULL,
  `filme_id` int(11) DEFAULT NULL,
  `texto` varchar(255) NOT NULL,
  `data_postagem` varchar(255) DEFAULT current_timestamp(),
  `nota` int(11) NOT NULL,
  `favorito` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `postagens`
--

INSERT INTO `postagens` (`id`, `credenciais_id`, `filme_id`, `texto`, `data_postagem`, `nota`, `favorito`) VALUES
(28, 52, 1, 'welington', '20/09/2024, 15:26', 2, 1),
(30, 52, 1, 'dsfdghksufodhsdhw', '20/09/2024, 14:52', 5, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tokensrevogados`
--

CREATE TABLE `tokensrevogados` (
  `token` varchar(255) NOT NULL,
  `tempoExpirado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tokensrevogados`
--

INSERT INTO `tokensrevogados` (`token`, `tempoExpirado`) VALUES
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Ikd1aWxoZXJtZUBnbWFpbC5jb20iLCJpYXQiOjE3MjQyNjUyNDksImV4cCI6MTcyNjg1NzI0OX0.6VvU2NpRLTHR5NKftDZyt93N9e7f_MbpeYWrvqeP5x4', '2024-09-20 18:34:09'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pY29sYXNAZ21haWwuY29tIiwiaWF0IjoxNzI0NDEzNzkyLCJleHAiOjE3MjcwMDU3OTJ9.TxfSQ2nzX-aX5gFvNB-MjQ4vQOObc1STmUAraZj_aEQ', '2024-09-22 11:49:52'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pY29sYXNAZ21haWwuY29tIiwiaWF0IjoxNzI0NDEzODQ5LCJleHAiOjE3MjcwMDU4NDl9.FAak3Kz5oQFMGU5ZMPVYhBIXGTXCY2tBX86IQIRZ7dA', '2024-09-22 11:50:49'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imdpb3Zhbm5hQGdtYWlsLmNvbSIsImlhdCI6MTcyNDQxMDg1OCwiZXhwIjoxNzI3MDAyODU4fQ.e0NpThFTJmV_fn0u8POCYADbPKiSvOJS1oI7DNpJXC4', '2024-09-22 11:00:58'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBlZHJvQHBoLmNvbSIsImlhdCI6MTcyNDQxMzUwMiwiZXhwIjoxNzI3MDA1NTAyfQ.Zwee6mWReaSEOsFeZtXFRzvbHB8YepiNvTjaklWtzMk', '2024-09-22 11:45:02'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoiamVzdXMiLCJpYXQiOjE3MjQ0MTkxMTUsImV4cCI6MTcyNzAxMTExNX0.RGaIxqEi4zGV8KP6AEbo_5_PzTMDVNW4mqgOS0pb9T8', '2024-09-22 13:18:35'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoicGVkcm8iLCJpYXQiOjE3MjQ0MTQwOTAsImV4cCI6MTcyNzAwNjA5MH0.P0Y7UhH_GlNggP8LvppHUod4tUjoERDtbHd2UAIPIWU', '2024-09-22 11:54:50'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoicGVkcm8iLCJpYXQiOjE3MjQ0MTQxMzAsImV4cCI6MTcyNzAwNjEzMH0.vUhiGhdXcK1a5e20-LoAVYXQuhTBQfnhWn6-B2D6FNw', '2024-09-22 11:55:30'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoicGVkcm9AcGguY29tIiwiaWF0IjoxNzI0NDEzNjgyLCJleHAiOjE3MjcwMDU2ODJ9.GRSbjJbAoDGeq6UkmIBwfbp0mBJtyb_s2xt9D9ktYf8', '2024-09-22 11:48:02'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoicGVkcm9AcGguY29tIiwiaWF0IjoxNzI0NDEzNTIzLCJleHAiOjE3MjcwMDU1MjN9.nm32bm6AVkyRtBcbnxA7yRXKQmRv3ZIoEeXGCr_dp2Q', '2024-09-22 11:45:23'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoiYnJpdG9GbGFtZW5nbyIsImlhdCI6MTcyNDI0NzA5MSwiZXhwIjoxNzI2ODM5MDkxfQ.C5yoIIIXfKzjjBhjNoVrfe5jV8YOBTkzgE0xTSwjxQs', '2024-09-20 13:31:31'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoiYnJpdG9GbGFtZW5nbyIsImlhdCI6MTcyNDI2MjA5NywiZXhwIjoxNzI2ODU0MDk3fQ.rO2hxYZgTVVZQYCHyBYBblJtcplwECvbr8CiySLy_tg', '2024-09-20 17:41:37'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoiYnJpdG9GbGFtZW5nbyIsImlhdCI6MTcyNDI2NDEwMSwiZXhwIjoxNzI2ODU2MTAxfQ.AFzNhBpjX1_Qu4LsntmMT7-7YLzDo_zUO0OHLElU_RM', '2024-09-20 18:15:01'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoiYnJpdG9GbGFtZW5nbyIsImlhdCI6MTcyNDQxMjkxOSwiZXhwIjoxNzI3MDA0OTE5fQ.GFwW7SQS4-jm1ZDknqs_ad26Qwp32ZtUbADNcvNgI9o', '2024-09-22 11:35:19'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoiYnJpdG9GbGFtZW5nbyIsImlhdCI6MTcyNDQxMTg3OSwiZXhwIjoxNzI3MDAzODc5fQ.HQSDdbJTZHR-sZQMbGL9auvYJvnf_RrlBpzo6NGl9zY', '2024-09-22 11:17:59'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoiYnJpdG9GbGFtZW5nbyIsImlhdCI6MTcyNDQxMzcwMiwiZXhwIjoxNzI3MDA1NzAyfQ.zVTapekWXu-QbEs3JosFonGmFXOrCuBRyOHtdEMyhCI', '2024-09-22 11:48:22'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoiYnJpdG9GbGFtZW5nbyIsImlhdCI6MTcyNDQxNDE1NCwiZXhwIjoxNzI3MDA2MTU0fQ.M7M3EObpkerI75poaDs37toWSaJuPvxzyKMOlYAKDxM', '2024-09-22 11:55:54'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbEVub21lIjoiYnJpdG9GbGFtZW5nbyIsImlhdCI6MTcyNDQxODEzOCwiZXhwIjoxNzI3MDEwMTM4fQ.wJqoHJMps5UJkXx-cLGseip42ukRGss12GRzH3ZS1dw', '2024-09-22 13:02:18'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Miwibm9tZVJlc3Bvc3RhIjoidGVzdGUiLCJpYXQiOjE3MjUwMzM1MTEsImV4cCI6MTcyNzYyNTUxMX0.6_si4_JI0HubCIJKTz9L0uHONCFgnNGC-DkjNA1mrAA', '2024-09-29 15:58:31'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibm9tZVJlc3Bvc3RhIjoidGVzdGUiLCJpYXQiOjE3MjQ4Njk5ODIsImV4cCI6MTcyNzQ2MTk4Mn0.5m4R9UB9UJ2964GdI9FklOUm4oCYzhGiwpuGlnTU-R0', '2024-09-27 18:33:02'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsIm5vbWVSZXNwb3N0YSI6Ik5hcnV0byIsImlhdCI6MTcyNTAzNzE0OCwiZXhwIjoxNzI3NjI5MTQ4fQ.QrdnGY3bAnkbWnyiXXx87o2WsDkY-c1olYXurRZDbos', '2024-09-29 16:59:08'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsIm5vbWVSZXNwb3N0YSI6IkJyaXRvIiwiaWF0IjoxNzI1MDM3MDYyLCJleHAiOjE3Mjc2MjkwNjJ9.qkq4NKftBbfKfxspD-N9fQy078Yi8lzhPjbDP0IR1Uw', '2024-09-29 16:57:42'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksIm5vbWVSZXNwb3N0YSI6IkZ1c2NhQXp1bCIsImlhdCI6MTcyNDQzNjcwOCwiZXhwIjoxNzI3MDI4NzA4fQ.jaPcNfBrOrBG0FbYhiy0iXomRfdJyUBxOMrtVXW7HwU', '2024-09-22 18:11:48'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksIm5vbWVSZXNwb3N0YSI6ImJyaXRvRmxhbWVuZ28iLCJpYXQiOjE3MjQ0MjExODQsImV4cCI6MTcyNzAxMzE4NH0.JtyaSyWDbkyWApJzAX9sp-kq86W-O65ibfThbBGvRd8', '2024-09-22 13:53:04'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksIm5vbWVSZXNwb3N0YSI6ImJyaXRvRmxhbWVuZ28iLCJpYXQiOjE3MjQ0MjgxMzgsImV4cCI6MTcyNzAyMDEzOH0.DDo3Eumr1zJw8KD5Xof2HL42PHmpwrKhJBIZRY6rLyA', '2024-09-22 15:48:58'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksIm5vbWVSZXNwb3N0YSI6ImJyaXRvRmxhbWVuZ28iLCJpYXQiOjE3MjQ0MjgxOTUsImV4cCI6MTcyNzAyMDE5NX0.1q9PZrxX84notcCe245R1QWJbKmFEuaCqCXGMBJgs2I', '2024-09-22 15:49:55'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksIm5vbWVSZXNwb3N0YSI6ImJyaXRvRmxhbWVuZ28iLCJpYXQiOjE3MjQ0MzA4MTQsImV4cCI6MTcyNzAyMjgxNH0.kCUp-v0_myd0kZvun7bmshwzVKGzlZcdIbCncZbxvTM', '2024-09-22 16:33:34'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksIm5vbWVSZXNwb3N0YSI6ImJyaXRvRmxhbWVuZ28iLCJpYXQiOjE3MjQ0MzE3NDIsImV4cCI6MTcyNzAyMzc0Mn0.wXUn_3K52yFr2_Dq7qlULXl9yjS8P4Ai_IQBeY6kZW0', '2024-09-22 16:49:02'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksIm5vbWVSZXNwb3N0YSI6ImJyaXRvRmxhbWVuZ28iLCJpYXQiOjE3MjQ0MzIwNjEsImV4cCI6MTcyNzAyNDA2MX0.GdRN0YLGFeCku0hcizINYrOK5D9B8hRWu98h1vtRRBQ', '2024-09-22 16:54:21'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksIm5vbWVSZXNwb3N0YSI6ImJyaXRvRmxhbWVuZ28iLCJpYXQiOjE3MjQ0MzYxOTAsImV4cCI6MTcyNzAyODE5MH0.1mUzZNUssA_m_WAmrz3m2J6SCXeSBfFtgvpnzM23-Sk', '2024-09-22 18:03:10'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDcsIm5vbWUiOiJKb8OjbyBQZWRybyAiLCJpYXQiOjE3MjQ0MzczNDUsImV4cCI6MTcyNzAyOTM0NX0.NwFjOz_FqNIlUH7ofX33Kq-CFeXONHkSboZR4BRcuUU', '2024-09-22 18:22:25'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDgsIm5vbWUiOiJCcml0byIsImlhdCI6MTcyNDQzNzQ1MSwiZXhwIjoxNzI3MDI5NDUxfQ.tjBR5ObBn2i56oQN3nB34TL1oHv-jH6H2McYhquEKT8', '2024-09-22 18:24:11'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDgsIm5vbWVSZXNwb3N0YSI6IkJyaXRvMTMyIiwiaWF0IjoxNzI0NDM3NTY2LCJleHAiOjE3MjcwMjk1NjZ9.KWl1S83tv4ZrwUFebh9Zu4YWFnHelNFaiPkw6xBVfps', '2024-09-22 18:26:06'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDksIm5vbWUiOiJFaWRoZGhzaHNoIiwiaWF0IjoxNzI0NDM3Njg3LCJleHAiOjE3MjcwMjk2ODd9.3jMMIp3LDQ9UDYWr6CzlhCtgVr-5McBTjxnB6wi2J1Q', '2024-09-22 18:28:07'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsIm5vbWUiOiJob2lkYWhvYXVnaHVodSIsImlhdCI6MTcyNDQzMjU2MiwiZXhwIjoxNzI3MDI0NTYyfQ.83iyb63jnB1OsKimH-jHYPceSfnFthCLD1JYiqISL7g', '2024-09-22 17:02:42'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsIm5vbWVSZXNwb3N0YSI6ImhvaWRhaG9hdWdodWh1IiwiaWF0IjoxNzI0NDMyNTc3LCJleHAiOjE3MjcwMjQ1Nzd9.E8lR0qR0e-hc3KdxbKBb4UZxtq-P1lxJ8cxYzTtm1p0', '2024-09-22 17:02:57'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsIm5vbWVSZXNwb3N0YSI6ImhvaWRhaG9hdWdodWh1IiwiaWF0IjoxNzI0NDMyOTI5LCJleHAiOjE3MjcwMjQ5Mjl9.i9cKvb7dTsXH-1pBzEIjVC8fVkBxcau4uu_r8DiK6MY', '2024-09-22 17:08:49'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsIm5vbWVSZXNwb3N0YSI6ImhvaWRhaG9hdWdodWh1IiwiaWF0IjoxNzI0NDMzMTE2LCJleHAiOjE3MjcwMjUxMTZ9.BMZOp5_92ITRWI7U3GjOyZj9ox_PBOyTMGUpBLMbuXU', '2024-09-22 17:11:56'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsIm5vbWVSZXNwb3N0YSI6ImhvaWRhaG9hdWdodWh1IiwiaWF0IjoxNzI0NDMzMTIxLCJleHAiOjE3MjcwMjUxMjF9.xE4i7vxSmPBNTrqmbTDJwHKoOYDCSYgTbiWIQj9pvuw', '2024-09-22 17:12:01'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDQsIm5vbWUiOiJzZHZrdWhmZGlnZmh1w6dzZmpvaSIsImlhdCI6MTcyNDQzMjYwMSwiZXhwIjoxNzI3MDI0NjAxfQ.eqZbPkwjrMvZt3IUqH80Rodwpm2KYPMaKQxYcVhOhds', '2024-09-22 17:03:21'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDUsIm5vbWUiOiJUT05PIiwiaWF0IjoxNzI0NDMyNjUwLCJleHAiOjE3MjcwMjQ2NTB9.-xDc1ibGiQb7-73r0HF43yhPbL3YlBU5hMnEemPU_R4', '2024-09-22 17:04:10'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDUsIm5vbWVSZXNwb3N0YSI6IlRPTk8iLCJpYXQiOjE3MjQ0MzI3MjcsImV4cCI6MTcyNzAyNDcyN30.y0IwHvYkg63Fq_S7IiX2VpFP0AmjuRZ0E6ha_ueSOQA', '2024-09-22 17:05:27'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDYsIm5vbWUiOiJQY0dhbWVyIiwiaWF0IjoxNzI0NDM3MDQ0LCJleHAiOjE3MjcwMjkwNDR9.z6kB35gVlIojR2pvibhZ0PBhtAhLatnU487CvsiSLOs', '2024-09-22 18:17:24'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDYsIm5vbWVSZXNwb3N0YSI6IlBjR2FtZXJCcmF6aWwiLCJpYXQiOjE3MjQ0MzcxODIsImV4cCI6MTcyNzAyOTE4Mn0.04Zvl5gmeGMf9B9tgl61uJ0FjHvsqT_B-WW7VNfuDPU', '2024-09-22 18:19:42'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDYsIm5vbWVSZXNwb3N0YSI6IlBjR2FtZXJCcmF6aWwiLCJpYXQiOjE3MjQ0MzcyODUsImV4cCI6MTcyNzAyOTI4NX0.wolXbqXmNbW64tm4OfKJKKWMJs7glSib2RR3dRrqzZA', '2024-09-22 18:21:25'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTEsIm5vbWUiOiJCcml0byIsImlhdCI6MTcyNTAzNTk0NSwiZXhwIjoxNzI3NjI3OTQ1fQ.mRlMA_XVCoBAaFYHvod_UPA3KOrNTSYsALOaj-GjvcI', '2024-09-29 16:39:05'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NDU0MzMxLCJleHAiOjE3MjgwNDYzMzF9.PjfkE_cr78qc5E005f4TEag7wEHWDjN87WKqS4m6dBA', '2024-10-04 12:52:11'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NDU0OTAxLCJleHAiOjE3MjgwNDY5MDF9.wvwxwBsySv8OLAXDttfiMDgTWU3qArru9FkK9cQOgFY', '2024-10-04 13:01:41'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NDU3ODMxLCJleHAiOjE3MjgwNDk4MzF9.Lu8BP9DfqG60WjPtopU2jx3KVTpJLVvj_N0KHCeOv3w', '2024-10-04 13:50:31'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NjIwOTk4LCJleHAiOjE3MjgyMTI5OTh9.sjIJlMl7YN4QbccXqT9VhiLRodNXgMg4pbeTtUnU1Gg', '2024-10-06 11:09:58'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NjM2MjY0LCJleHAiOjE3MjgyMjgyNjR9.yrwOyOG1VB2M5HcX67IXodPf9tez6R8kBdMjfAq1B7s', '2024-10-06 15:24:24'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI2MDU2MTg3LCJleHAiOjE3Mjg2NDgxODd9.Iw2KiDnrkmUB7BAqN6zMvpFfUKGU2FB7QwexHGMvznI', '2024-10-11 12:03:07'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI2MjI1Nzk5LCJleHAiOjE3Mjg4MTc3OTl9.TJe-Nu845C8cGmjjjHDnOpSx-XyCjmF66KghJdxZVhA', '2024-10-13 11:09:59'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI2ODM0MjA1LCJleHAiOjE3Mjk0MjYyMDV9.Gg1eJ66YIYXADkE6uqno_gaS9hwXRtcNaKPOoEfcZDs', '2024-10-20 12:10:05'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTQsIm5vbWUiOiJzb2NyYXRlcyIsImlhdCI6MTcyNTYyMTgxNCwiZXhwIjoxNzI4MjEzODE0fQ.trcl1cmmADYXZz0Xcx4ET2wUjb6HJ9nCtTpbPYoqXCU', '2024-10-06 11:23:34'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTUsIm5vbWUiOiJQYXVsaW5obyIsImlhdCI6MTcyNjIyNjQyMSwiZXhwIjoxNzI4ODE4NDIxfQ.pmxrFZBmRLJ9OgId1zbRXv275PZiGTGwvGCiBSRy2Kw', '2024-10-13 11:20:21'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTUsIm5vbWVSZXNwb3N0YSI6IlBhdWxpbmhvRGFWaW9sYSIsImlhdCI6MTcyNjIyNjU2NCwiZXhwIjoxNzI4ODE4NTY0fQ.9l70zMg8_VbJ62Gqg1BpM2fzvxpgGncfHCngf3soQJ4', '2024-10-13 11:22:44'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJub21lUmVzcG9zdGEiOiJicml0b0ZsYW1lbmdvIiwiaWF0IjoxNzI0NDIwODIwLCJleHAiOjE3MjcwMTI4MjB9.iccKFoCo7HH6w7-OisI1HeZODOMorMgkmjYzzsCWXxM', '2024-09-22 13:47:00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_cadastro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `credenciais`
--
ALTER TABLE `credenciais`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `curtidas`
--
ALTER TABLE `curtidas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Índices de tabela `descurtidas`
--
ALTER TABLE `descurtidas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Índices de tabela `filmes`
--
ALTER TABLE `filmes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `postagens`
--
ALTER TABLE `postagens`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tokensrevogados`
--
ALTER TABLE `tokensrevogados`
  ADD PRIMARY KEY (`token`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `credenciais`
--
ALTER TABLE `credenciais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT de tabela `curtidas`
--
ALTER TABLE `curtidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `descurtidas`
--
ALTER TABLE `descurtidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `filmes`
--
ALTER TABLE `filmes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `postagens`
--
ALTER TABLE `postagens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `curtidas`
--
ALTER TABLE `curtidas`
  ADD CONSTRAINT `curtidas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `curtidas_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`);

--
-- Restrições para tabelas `descurtidas`
--
ALTER TABLE `descurtidas`
  ADD CONSTRAINT `descurtidas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `descurtidas_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
