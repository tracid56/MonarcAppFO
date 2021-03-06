SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `anrs`;
TRUNCATE TABLE `amvs`;
TRUNCATE TABLE `anrs_objects`;
TRUNCATE TABLE `anrs_objects_categories`;
TRUNCATE TABLE `assets`;
TRUNCATE TABLE `deliveries`;
TRUNCATE TABLE `instances`;
TRUNCATE TABLE `instances_consequences`;
TRUNCATE TABLE `instances_risks`;
TRUNCATE TABLE `instances_risks_op`;
TRUNCATE TABLE `interviews`;
TRUNCATE TABLE `measures`;
TRUNCATE TABLE `measures_amvs`;
TRUNCATE TABLE `measures_measures`;
TRUNCATE TABLE `measures_rolf_risks`;
TRUNCATE TABLE `objects`;
TRUNCATE TABLE `objects_categories`;
TRUNCATE TABLE `objects_objects`;
TRUNCATE TABLE `questions`;
TRUNCATE TABLE `questions_choices`;
TRUNCATE TABLE `recommandations`;
TRUNCATE TABLE `recommandations_risks`;
TRUNCATE TABLE `recommandations_sets`;
TRUNCATE TABLE `referentials`;
TRUNCATE TABLE `rolf_risks_tags`;
TRUNCATE TABLE `rolf_risks`;
TRUNCATE TABLE `rolf_tags`;
TRUNCATE TABLE `scales`;
TRUNCATE TABLE `scales_comments`;
TRUNCATE TABLE `scales_impact_types`;
TRUNCATE TABLE `soa`;
TRUNCATE TABLE `soacategory`;
TRUNCATE TABLE `snapshots`;
TRUNCATE TABLE `themes`;
TRUNCATE TABLE `threats`;
TRUNCATE TABLE `user_tokens`;
TRUNCATE TABLE `users`;
TRUNCATE TABLE `users_anrs`;
TRUNCATE TABLE `users_roles`;
TRUNCATE TABLE `vulnerabilities`;

SET FOREIGN_KEY_CHECKS = 1;
