CREATE TABLE IF NOT EXISTS `#__pf_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Comment ID',
  `asset_id` int(10) unsigned NOT NULL COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent project ID',
  `item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent item ID',
  `context` varchar(50) NOT NULL COMMENT 'Context reference',
  `title` varchar(128) NOT NULL COMMENT 'The context item title',
  `alias` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` text NOT NULL COMMENT 'Comment content',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Comment creation date',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Comment author',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Comment modify date',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Last user to modify the comment',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User who is currently editing the comment',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Comment attributes in JSON format',
  `state` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'Comment state: 1 = Active, 0 = Inactive, 2 = Archived, -2 = Trashed ',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Adjacency List Reference ID',
  `lft` int(11) NOT NULL COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL COMMENT 'Nested set rgt.',
  `level` int(10) unsigned NOT NULL COMMENT 'Nested comment level',
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`),
  KEY `idx_contextitemid` (`context`,`item_id`),
  KEY `idx_state` (`state`),
  KEY `idx_parentid` (`parent_id`),
  KEY `idx_nested` (`lft`,`rgt`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork item comments';


CREATE TABLE IF NOT EXISTS `#__pf_labels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Label ID',
  `project_id` int(10) unsigned NOT NULL COMMENT 'The parent project id',
  `title` varchar(32) NOT NULL COMMENT 'Label title',
  `style` varchar(24) NOT NULL COMMENT 'Label CSS style',
  `asset_group` varchar(50) NOT NULL COMMENT 'Assigned label asset group',
  PRIMARY KEY (`id`),
  KEY `idx_group` (`project_id`,`asset_group`),
  KEY `idx_project` (`project_id`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork labels';

CREATE TABLE IF NOT EXISTS `#__pf_milestones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Milestone ID',
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent project ID',
  `title` varchar(128) NOT NULL COMMENT 'Milestone title',
  `alias` varchar(128) NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` varchar(255) NOT NULL COMMENT 'Milestone description',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Milestone creation date',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Milestone author',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Milestone modify date',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Last user to modify the milestone',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User who is currently editing the milestone',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Milestone attributes in JSON format',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Milestone ACL access level ID',
  `state` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'Milestone state: 1 = Active, 0 = Inactive, 2 = Archived, -2 = Trashed ',
  `ordering` int(10) NOT NULL DEFAULT '0' COMMENT 'Milestone ordering',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Milestone start date',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Milestone end date',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`alias`,`project_id`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_access` (`access`),
  KEY `idx_state` (`state`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork milestone data';

CREATE TABLE IF NOT EXISTS `#__pf_projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Project ID',
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table',
  `catid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `title` varchar(128) NOT NULL COMMENT 'Project title',
  `alias` varchar(128) NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` text NOT NULL COMMENT 'Project description',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Project creation date',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Project owner',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Project modify date',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Last user to modify the project',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User who is currently editing the project',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Project attributes in JSON format',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Project ACL access level ID',
  `state` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'Project state: 1 = Active, 0 = Inactive, 2 = Archived, -2 = Trashed',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Project start date',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Project end date',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`alias`),
  KEY `idx_catid` (`catid`),
  KEY `idx_access` (`access`),
  KEY `idx_state` (`state`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork project data';

CREATE TABLE IF NOT EXISTS `#__pf_ref_attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Reference ID',
  `item_type` varchar(32) NOT NULL COMMENT 'The item type',
  `item_id` int(10) unsigned NOT NULL COMMENT 'The item id',
  `project_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The project id',
  `attachment` varchar(128) NOT NULL COMMENT 'The attachment type and id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_connection` (`attachment`,`item_id`,`item_type`),
  KEY `idx_item` (`item_type`,`item_id`),
  KEY `idx_project` (`project_id`),
  KEY `idx_attachment` (`attachment`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork attachment references';

CREATE TABLE IF NOT EXISTS `#__pf_ref_observer` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'The observing user',
  `item_type` varchar(50) NOT NULL COMMENT 'The observed item type',
  `item_id` int(10) unsigned NOT NULL COMMENT 'The observed item ID',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Project ID to which the item belongs',
  UNIQUE KEY `idx_observing` (`item_type`,`item_id`,`user_id`),
  KEY `idx_project` (`project_id`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork notification settings';

CREATE TABLE IF NOT EXISTS `#__pf_ref_labels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID reference',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Parent project id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Reference item ID',
  `item_type` varchar(50) NOT NULL COMMENT 'Reference item type',
  `label_id` int(10) unsigned NOT NULL COMMENT 'Reference label ID',
  PRIMARY KEY (`id`),
  KEY `idx_project` (`project_id`),
  KEY `idx_item` (`item_id`,`item_type`),
  KEY `idx_lbl` (`label_id`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork label references';

CREATE TABLE IF NOT EXISTS `#__pf_ref_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID reference',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Task project ID',
  `task_id` int(10) unsigned NOT NULL COMMENT 'Task ID',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent task ID',
  PRIMARY KEY (`id`),
  KEY `idx_task` (`task_id`),
  KEY `idx_parent` (`parent_id`),
  KEY `idx_project` (`project_id`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork task dependencies';

CREATE TABLE IF NOT EXISTS `#__pf_ref_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID reference',
  `item_type` varchar(50) NOT NULL COMMENT 'The item type',
  `item_id` int(10) unsigned NOT NULL COMMENT 'The item id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID reference',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`user_id`,`item_id`,`item_type`),
  KEY `idx_item` (`item_type`,`item_id`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork user references';

CREATE TABLE IF NOT EXISTS `#__pf_tags` (
  `id` int(10) unsigned NOT NULL COMMENT 'Tag ID',
  `title` varchar(64) NOT NULL COMMENT 'Tag title',
  `alias` varchar(64) NOT NULL COMMENT 'Tag alias',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`alias`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork tags';

CREATE TABLE IF NOT EXISTS `#__pf_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Task ID',
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent project ID',
  `list_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent task list ID',
  `milestone_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent milestone ID',
  `title` varchar(128) NOT NULL COMMENT 'Task title',
  `alias` varchar(128) NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` text NOT NULL COMMENT 'Task description',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Task creation date',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Task author',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Task modify date',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Last user to modify the task',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User who is currently editing the task',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Task attributes in JSON format',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Task ACL access level ID',
  `state` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'Task state: 1 = Active, 0 = Inactive, 2 = Archived, -2 = Trashed ',
  `priority` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'Task priority ID',
  `complete` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Task complete state',
  `completed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Task completition date',
  `completed_by` int(10) unsigned NOT NULL COMMENT 'The user who completed the task',
  `ordering` int(10) NOT NULL DEFAULT '0' COMMENT 'Task ordering in a task list',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Task start date',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Task end date',
  `rate` decimal(5,2) NOT NULL COMMENT 'Hourly rate',
  `estimate` int(10) unsigned NOT NULL COMMENT 'Estimated time required for this task to complete',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`project_id`,`milestone_id`,`list_id`,`alias`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_listid` (`list_id`),
  KEY `idx_milestone` (`milestone_id`),
  KEY `idx_access` (`access`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`),
  KEY `idx_priority` (`priority`),
  KEY `idx_complete` (`complete`),
  KEY `idx_state` (`state`),
  KEY `idx_completedby` (`completed_by`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork task data';

CREATE TABLE IF NOT EXISTS `#__pf_task_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Task list ID',
  `asset_id` int(10) NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent project ID',
  `milestone_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent milestone ID',
  `title` varchar(64) NOT NULL COMMENT 'Task list title',
  `alias` varchar(64) NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` varchar(255) NOT NULL COMMENT 'Task list description',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Task list creation date',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Task list creator',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Task list modify date',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Last user to modify the task list',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User who is currently editing the task list',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Task list attributes in JSON format',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Task List ACL access level ID',
  `state` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'Task list state: 1 = Active, 0 = Inactive, 2 = Archived, -2 = Trashed ',
  `ordering` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Task list ordering',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`project_id`,`alias`,`milestone_id`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_milestoneid` (`milestone_id`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_access` (`access`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork task list data';

CREATE TABLE IF NOT EXISTS `#__pf_topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Topic ID',
  `asset_id` int(10) NOT NULL COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Parent project ID',
  `title` varchar(124) NOT NULL COMMENT 'Topic title',
  `alias` varchar(124) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` text NOT NULL COMMENT 'Topic content text',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Topic creation date',
  `created_by` int(10) unsigned NOT NULL COMMENT 'Topic author',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Topic modify date',
  `modified_by` int(10) unsigned NOT NULL COMMENT 'Last user to modify the topic',
  `checked_out` int(10) unsigned NOT NULL COMMENT 'User who is currently editing the topic',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Topic attributes in JSON format',
  `access` int(10) unsigned NOT NULL COMMENT 'Topic ACL access level ID',
  `state` tinyint(3) NOT NULL COMMENT 'Topic state: 1 = Active, 0 = Inactive, 2 = Archived, -2 = Trashed',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`project_id`,`alias`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_access` (`access`),
  KEY `idx_state` (`state`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork discussion topics';

CREATE TABLE IF NOT EXISTS `#__pf_replies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Topic ID',
  `asset_id` int(10) NOT NULL COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Parent project ID',
  `topic_id` int(10) unsigned NOT NULL COMMENT 'Parent topic ID',
  `description` text NOT NULL COMMENT 'Reply content text',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Reply creation date',
  `created_by` int(10) unsigned NOT NULL COMMENT 'Reply author',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Reply modify date',
  `modified_by` int(10) unsigned NOT NULL COMMENT 'Last user to modify the reply',
  `checked_out` int(10) unsigned NOT NULL COMMENT 'User who is currently editing the reply',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Reply attributes in JSON format',
  `access` int(10) unsigned NOT NULL COMMENT 'Reply ACL access level ID',
  `state` tinyint(3) NOT NULL COMMENT 'Reply state: 1 = Active, 0 = Inactive, 2 = Archived, -2 = Trashed',
  PRIMARY KEY (`id`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_topicid` (`topic_id`),
  KEY `idx_access` (`access`),
  KEY `idx_state` (`state`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork discussion replies';

CREATE TABLE IF NOT EXISTS `#__pf_timesheet` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Parent project ID',
  `task_id` int(10) unsigned NOT NULL COMMENT 'Parent task ID',
  `task_title` varchar(128) NOT NULL COMMENT 'Parent task title',
  `description` varchar(255) NOT NULL COMMENT 'Description text',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation date',
  `created_by` int(10) unsigned NOT NULL COMMENT 'Time author',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Time modify date',
  `modified_by` int(10) unsigned NOT NULL COMMENT 'Last user to modify the record',
  `checked_out` int(10) unsigned NOT NULL COMMENT 'User who is currently editing this record',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Record attributes in JSON format',
  `billable` tinyint(1) NOT NULL COMMENT '1 = Billable, 0 = Unbillable',
  `rate` decimal(5,2) NOT NULL COMMENT 'Hourly rate',
  `access` int(10) unsigned NOT NULL COMMENT 'Record ACL access level ID',
  `state` tinyint(3) NOT NULL COMMENT 'Record state: 1 = Active, 0 = Inactive, 2 = Archived, -2 = Trashed ',
  `log_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Time log date',
  `log_time` int(10) unsigned NOT NULL COMMENT 'Time log seconds',
  PRIMARY KEY (`id`),
  KEY `idx_project` (`project_id`),
  KEY `idx_task` (`task_id`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`),
  KEY `idx_access` (`access`),
  KEY `idx_state` (`state`),
  KEY `idx_billable` (`billable`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork time spent on tasks';

CREATE TABLE IF NOT EXISTS `#__pf_repo_dirs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Directory ID',
  `asset_id` int(10) unsigned NOT NULL COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Parent project id',
  `title` varchar(56) NOT NULL COMMENT 'Directory title',
  `alias` varchar(56) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` varchar(128) NOT NULL COMMENT 'Directory description text',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Directory creation date',
  `created_by` int(10) unsigned NOT NULL COMMENT 'Directory author',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Directory modify date',
  `modified_by` int(10) unsigned NOT NULL COMMENT 'Last user to modify the directory',
  `checked_out` int(10) unsigned NOT NULL COMMENT 'User who is currently editing the directory',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Directory attributes in JSON format',
  `access` int(10) unsigned NOT NULL COMMENT 'Directory ACL access level ID',
  `protected` tinyint(1) NOT NULL COMMENT 'If set to 1, directories cannot be deleted manually',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Adjacency List Reference ID',
  `lft` int(10) NOT NULL COMMENT 'Nested set lft.',
  `rgt` int(10) NOT NULL COMMENT 'Nested set rgt.',
  `level` int(10) unsigned NOT NULL COMMENT 'Nested directory level',
  `path` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Directory path',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`alias`,`parent_id`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`),
  KEY `idx_parentid` (`parent_id`),
  KEY `idx_nested` (`lft`,`rgt`),
  KEY `idx_access` (`access`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork repository directory information';

CREATE TABLE IF NOT EXISTS `#__pf_repo_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Note ID',
  `asset_id` int(10) NOT NULL COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Parent project ID',
  `dir_id` int(10) unsigned NOT NULL COMMENT 'Parent directory ID',
  `title` varchar(56) NOT NULL COMMENT 'Note title',
  `alias` varchar(56) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` text NOT NULL COMMENT 'Note content text',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Note creation date',
  `created_by` int(10) unsigned NOT NULL COMMENT 'Note author',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Note modify date',
  `modified_by` int(10) unsigned NOT NULL COMMENT 'Last user to modify the note',
  `checked_out` int(10) unsigned NOT NULL COMMENT 'User who is currently editing the note',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'Note attributes in JSON format',
  `access` int(10) unsigned NOT NULL COMMENT 'Note ACL access level ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`dir_id`,`alias`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_dirid` (`dir_id`),
  KEY `idx_access` (`access`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork notes';

CREATE TABLE IF NOT EXISTS `#__pf_repo_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID',
  `asset_id` int(10) NOT NULL COMMENT 'FK to the #__assets table',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Parent project ID',
  `dir_id` int(10) unsigned NOT NULL COMMENT 'Parent directory ID',
  `title` varchar(56) NOT NULL COMMENT 'File title',
  `alias` varchar(56) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` varchar(128) NOT NULL COMMENT 'File description',
  `file_name` varchar(255) NOT NULL COMMENT 'The file name',
  `file_extension` varchar(32) NOT NULL COMMENT 'The file extension name',
  `file_size` int(10) unsigned NOT NULL COMMENT 'The file size in kilobyte',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'File creation date',
  `created_by` int(10) unsigned NOT NULL COMMENT 'File author',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'File modify date',
  `modified_by` int(10) unsigned NOT NULL COMMENT 'Last user to modify the file',
  `checked_out` int(10) unsigned NOT NULL COMMENT 'User who is currently editing the file',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Check-out date and time',
  `attribs` text NOT NULL COMMENT 'File attributes in JSON format',
  `access` int(10) unsigned NOT NULL COMMENT 'File ACL access level ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`dir_id`,`alias`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_dirid` (`dir_id`),
  KEY `idx_access` (`access`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_checkedout` (`checked_out`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork file details';

CREATE TABLE IF NOT EXISTS `#__pf_repo_file_revs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Parent project ID',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'File head revision id',
  `title` varchar(56) NOT NULL COMMENT 'File title',
  `alias` varchar(56) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` varchar(128) NOT NULL COMMENT 'File description',
  `file_name` varchar(255) NOT NULL COMMENT 'The file name',
  `file_extension` varchar(32) NOT NULL COMMENT 'The file extension name',
  `file_size` int(10) unsigned NOT NULL COMMENT 'The file size in kilobyte',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'File creation date',
  `created_by` int(10) unsigned NOT NULL COMMENT 'File author',
  `attribs` text NOT NULL COMMENT 'File attributes in JSON format',
  `ordering` int(10) NOT NULL COMMENT 'File revision number',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`alias`,`parent_id`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_createdby` (`created_by`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork file version details';

CREATE TABLE IF NOT EXISTS `#__pf_repo_note_revs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Note ID',
  `project_id` int(10) unsigned NOT NULL COMMENT 'Parent project ID',
  `parent_id` int(10) NOT NULL COMMENT 'Parent Note ID',
  `title` varchar(56) NOT NULL COMMENT 'Note title',
  `alias` varchar(56) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Title alias. Used in SEF URL''s',
  `description` text NOT NULL COMMENT 'Note content text',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Note creation date',
  `created_by` int(10) unsigned NOT NULL COMMENT 'Note author',
  `attribs` text NOT NULL COMMENT 'Note attributes in JSON format',
  `ordering` int(10) NOT NULL COMMENT 'Note revision number',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias` (`alias`,`parent_id`),
  KEY `idx_projectid` (`project_id`),
  KEY `idx_createdby` (`created_by`)
) DEFAULT CHARSET=utf8 COMMENT='Stores Projectfork note revisions';
