-- Cria tabelas para substantivos, verbos e suas relações semânticas.
-- MySQL / MariaDB

CREATE TABLE IF NOT EXISTS substantivos (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    singular VARCHAR(255) NOT NULL,
    plural VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_substantivos_singular (singular)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS verbos (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    forma_base VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_verbos_forma_base (forma_base)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS subs_verbs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_substantivo INT UNSIGNED NOT NULL,
    id_verbo INT UNSIGNED NOT NULL,
    orientacao TINYINT UNSIGNED NOT NULL COMMENT '1 = substantivo executa a ação; 2 = substantivo sofre a ação',
    PRIMARY KEY (id),
    UNIQUE KEY uq_subs_verbs_relacao (id_substantivo, id_verbo, orientacao),
    KEY idx_subs_verbs_id_verbo (id_verbo),
    CONSTRAINT fk_subs_verbs_substantivo
        FOREIGN KEY (id_substantivo) REFERENCES substantivos (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_subs_verbs_verbo
        FOREIGN KEY (id_verbo) REFERENCES verbos (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT chk_subs_verbs_orientacao CHECK (orientacao IN (1, 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
