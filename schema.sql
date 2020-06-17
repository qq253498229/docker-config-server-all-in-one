CREATE DATABASE if not exists application_configuration;
USE application_configuration;

CREATE TABLE if not exists `system_project`
(
    `project_id`   bigint(20)                              NOT NULL auto_increment,
    `project_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目名',
    `project_code` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目编号',
    PRIMARY KEY (`project_id`),
    CONSTRAINT `system_project_project_code_uindex` UNIQUE (`project_code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT = '项目表';

CREATE TABLE if not exists `system_app`
(
    `app_id`     bigint(20)                              NOT NULL auto_increment,
    `app_name`   varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
    `app_code`   varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用编码',
    `project_id` bigint(20)                              NOT NULL COMMENT '项目id(外键)',
    PRIMARY KEY (`app_id`),
    CONSTRAINT `system_app_app_code_uindex` UNIQUE (`app_code`),
    CONSTRAINT `system_app_project_id_fk` FOREIGN KEY (`project_id`) REFERENCES `system_project` (`project_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT = '应用表';

CREATE TABLE if not exists `system_env`
(
    `env_id`     bigint(20)                              NOT NULL auto_increment,
    `env_name`   varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '环境名',
    `env_code`   varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '环境编号',
    `project_id` bigint(20)                              NOT NULL COMMENT '项目id(外键)',
    PRIMARY KEY (`env_id`),
    CONSTRAINT `system_env_env_code_uindex` UNIQUE (`env_code`),
    CONSTRAINT `system_env_project_id_fk` FOREIGN KEY (`project_id`) REFERENCES `system_project` (`project_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT = '环境表';

CREATE TABLE if not exists `system_config`
(
    `config_id`   bigint(20)                              NOT NULL auto_increment,
    `config_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名',
    `env_id`      bigint(20)                              NOT NULL COMMENT '环境id(外键)',
    PRIMARY KEY (`config_id`),
    CONSTRAINT `system_config_env_id_fk` FOREIGN KEY (`env_id`) REFERENCES `system_env` (`env_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT = '配置表';


CREATE TABLE if not exists `system_property`
(
    `property_id`    bigint(20)                              NOT NULL auto_increment,
    `property_key`   varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '属性名',
    `property_value` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '属性值',
    `property_type`  varchar(50) COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT 'STRING,INTEGER,BOOLEAN',
    `config_id`      bigint(20)                              NOT NULL COMMENT '配置id(外键)',
    PRIMARY KEY (`property_id`),
    CONSTRAINT `system_property_config_id_fk` FOREIGN KEY (`config_id`) REFERENCES `system_config` (`config_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT = '属性表';

CREATE TABLE if not exists `relationship_app_config`
(
    `app_id`    bigint(20) NOT NULL,
    `config_id` bigint(20) NOT NULL,
    PRIMARY KEY (`config_id`, `app_id`),
    CONSTRAINT `relationship_app_config_app_id_fk` FOREIGN KEY (`app_id`) REFERENCES `system_app` (`app_id`),
    CONSTRAINT `relationship_app_config_config_id_fk` FOREIGN KEY (`config_id`) REFERENCES `system_config` (`config_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT = '应用配置中间表';