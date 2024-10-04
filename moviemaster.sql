-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 04/10/2024 às 20:42
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
-- Estrutura para tabela `amigos`
--

CREATE TABLE `amigos` (
  `id` int(11) NOT NULL,
  `credenciais_id` int(11) NOT NULL,
  `amigos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`amigos`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `amigos`
--

INSERT INTO `amigos` (`id`, `credenciais_id`, `amigos`) VALUES
(3, 52, '[28]');

-- --------------------------------------------------------

--
-- Estrutura para tabela `credenciais`
--

CREATE TABLE `credenciais` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `foto` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Estrutura para tabela `favoritos`
--

CREATE TABLE `favoritos` (
  `id` int(11) NOT NULL,
  `idFilme` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `capa` varchar(255) NOT NULL
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
  `favorito` tinyint(1) NOT NULL,
  `autor` varchar(255) NOT NULL,
  `tituloDoFilme` varchar(255) NOT NULL,
  `likesDaPostagem` int(11) NOT NULL,
  `capaDoFilme` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `postagens`
--

INSERT INTO `postagens` (`id`, `credenciais_id`, `filme_id`, `texto`, `data_postagem`, `nota`, `favorito`, `autor`, `tituloDoFilme`, `likesDaPostagem`, `capaDoFilme`) VALUES
(43, 52, 519182, 'asdasdasddasdsadsadasd', '02/10/2024, 10:33', 0, 0, 'Brito', 'Meu Malvado Favorito 4', 0, 'https://image.tmdb.org/t/p/w500/jWYTtmxSuWVXP22hxAeXdQZLZrh.jpg'),
(44, 52, 1184918, 'robo chato', '02/10/2024, 10:38', 1, 0, 'Brito', 'Robô Selvagem', 0, 'https://image.tmdb.org/t/p/w500/pG9Vfb3r0Nwd0QO7g01CNaOowXX.jpg'),
(45, 57, 573435, 'Bom', '02/10/2024, 09:50', 0, 0, 'Pedroh', 'Bad Boys: Até o Fim', 0, 'https://image.tmdb.org/t/p/w500/ak6VZDHms5T4p0eFISk336kqjR6.jpg'),
(46, 57, 573435, 'Bom', '02/10/2024, 09:50', 4, 0, 'Pedroh', 'Bad Boys: Até o Fim', 0, 'https://image.tmdb.org/t/p/w500/ak6VZDHms5T4p0eFISk336kqjR6.jpg'),
(47, 57, 573435, 'Bom', '02/10/2024, 09:51', 4, 0, 'Pedroh', 'Bad Boys: Até o Fim', 0, 'https://image.tmdb.org/t/p/w500/ak6VZDHms5T4p0eFISk336kqjR6.jpg'),
(48, 57, 573435, 'Bom', '02/10/2024, 09:51', 4, 0, 'Pedroh', 'Bad Boys: Até o Fim', 0, 'https://image.tmdb.org/t/p/w500/ak6VZDHms5T4p0eFISk336kqjR6.jpg'),
(49, 57, 857, 'Bomdemais', '02/10/2024, 09:54', 4, 1, 'Pedroh', 'O Resgate do Soldado Ryan', 0, 'https://image.tmdb.org/t/p/w500/hMLxNLCXRDd62acfCBn6mIyW1HU.jpg'),
(50, 52, 1329912, 'efsdfdsfsfsdfss', '02/10/2024, 12:03', 5, 1, 'Brito', 'Kung Fu Games', 0, 'https://image.tmdb.org/t/p/w500/yjDdBBUEBMvyUiVohZ8T7W2IFl6.jpg'),
(51, 58, 573435, 'Bad Boys What you Gonna Do When they come for you', '02/10/2024, 12:14', 5, 0, 'João Pedro', 'Bad Boys: Até o Fim', 0, 'https://image.tmdb.org/t/p/w500/ak6VZDHms5T4p0eFISk336kqjR6.jpg'),
(52, 58, 573435, 'Bad Boys What you Gonna Do When they come for you', '02/10/2024, 12:14', 5, 1, 'João Pedro', 'Bad Boys: Até o Fim', 0, 'https://image.tmdb.org/t/p/w500/ak6VZDHms5T4p0eFISk336kqjR6.jpg'),
(53, 59, 12, 'bom demias', '02/10/2024, 12:18', 5, 1, 'Isabela', 'Procurando Nemo', 0, 'https://image.tmdb.org/t/p/w500/5jrPMq7IMLTqcuPDlK6jfruEbpq.jpg'),
(54, 52, 18491, 'o nicolas viu', '02/10/2024, 13:11', 1, 0, 'Brito', 'Neon Genesis Evangelion: O Fim do Evangelho', 0, 'https://image.tmdb.org/t/p/w500/txDIbdn7p6eYdFMVoHbd4wwrNkM.jpg'),
(55, 52, 1184918, 'dsdsdsdsddsdddsdd', '02/10/2024, 13:47', 5, 1, 'Brito', 'Robô Selvagem', 0, 'https://image.tmdb.org/t/p/w500/pG9Vfb3r0Nwd0QO7g01CNaOowXX.jpg'),
(56, 52, 1184918, 'dahora', '02/10/2024, 13:58', 5, 1, 'Brito', 'Robô Selvagem', 0, 'https://image.tmdb.org/t/p/w500/pG9Vfb3r0Nwd0QO7g01CNaOowXX.jpg'),
(57, 52, 877817, 'SDASADASDDADASD', '04/10/2024, 13:10', 4, 1, 'Brito', 'Lobos', 0, 'https://image.tmdb.org/t/p/w500/5LvefZZsapIsOIckLZHbYlwCAkm.jpg');

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
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6IkJyaXRvIiwiaWF0IjoxNzI4MDQyMDAzLCJleHAiOjE3MzA2MzQwMDN9.iqk2p9Fdpd7o0UQozMUGI2RLFLpxJOAy6H822Q40Coo', '2024-11-03 11:40:03'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NDU0MzMxLCJleHAiOjE3MjgwNDYzMzF9.PjfkE_cr78qc5E005f4TEag7wEHWDjN87WKqS4m6dBA', '2024-10-04 12:52:11'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NDU0OTAxLCJleHAiOjE3MjgwNDY5MDF9.wvwxwBsySv8OLAXDttfiMDgTWU3qArru9FkK9cQOgFY', '2024-10-04 13:01:41'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NDU3ODMxLCJleHAiOjE3MjgwNDk4MzF9.Lu8BP9DfqG60WjPtopU2jx3KVTpJLVvj_N0KHCeOv3w', '2024-10-04 13:50:31'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NjIwOTk4LCJleHAiOjE3MjgyMTI5OTh9.sjIJlMl7YN4QbccXqT9VhiLRodNXgMg4pbeTtUnU1Gg', '2024-10-06 11:09:58'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI1NjM2MjY0LCJleHAiOjE3MjgyMjgyNjR9.yrwOyOG1VB2M5HcX67IXodPf9tez6R8kBdMjfAq1B7s', '2024-10-06 15:24:24'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI2MDU2MTg3LCJleHAiOjE3Mjg2NDgxODd9.Iw2KiDnrkmUB7BAqN6zMvpFfUKGU2FB7QwexHGMvznI', '2024-10-11 12:03:07'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI2MjI1Nzk5LCJleHAiOjE3Mjg4MTc3OTl9.TJe-Nu845C8cGmjjjHDnOpSx-XyCjmF66KghJdxZVhA', '2024-10-13 11:09:59'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI2ODM0MjA1LCJleHAiOjE3Mjk0MjYyMDV9.Gg1eJ66YIYXADkE6uqno_gaS9hwXRtcNaKPOoEfcZDs', '2024-10-20 12:10:05'),
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTIsIm5vbWVSZXNwb3N0YSI6InRlc3RlIiwiaWF0IjoxNzI3Mjg2MTkxLCJleHAiOjE3Mjk4NzgxOTF9.3HvpNBpslYegke7X_6qGRB51rwmhY0cHTJT-T8_fKJU', '2024-10-25 17:43:11'),
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
-- Índices de tabela `amigos`
--
ALTER TABLE `amigos`
  ADD PRIMARY KEY (`id`);

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
-- Índices de tabela `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT de tabela `amigos`
--
ALTER TABLE `amigos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `credenciais`
--
ALTER TABLE `credenciais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

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
-- AUTO_INCREMENT de tabela `favoritos`
--
ALTER TABLE `favoritos`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

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
