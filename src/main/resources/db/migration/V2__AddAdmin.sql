insert into boardapp_users (id, username, password, active) values (1, 'Newt', '$2a$08$CP40orzFxW7nPXiUpVJkhuuwJocbg/yh07naIK9oNfBAuBjKDcKGq', true);

insert into user_roles (user_id, roles) values (1, 'USER'), (1, 'ADMIN');