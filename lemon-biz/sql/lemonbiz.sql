select * from calendar;
select * from member;
commit;

drop table calendar;

drop sequence seq_calendar_no;

create table calendar(
    calendar_id number,
    calendar_member_id varchar2(20),
    calendar_title varchar2(100) not null,
    calendar_allday char(1) default '0',
    calendar_start varchar2(100) not null,
    calendar_end varchar2(100) not null,
    calendar_content varchar2(3000) not null,
    calendar_type varchar2(20),
    calendar_color varchar2(20),
    constraint pk_calender_id primary key(calendar_id),
    --constraint fk_calendar_member_id foreign key(calendar_member_id) references member(member_id) on delete cascade,
    constraint ck_calendar_allday check(calendar_allday in ('1','0'))
);

create sequence seq_calendar_no;

commit;

select * from member;

create table cost(
    member_id varchar2(20) not null,
    transportation_costs number,
    fitment number,
    business_costs number,
    meal_costs number,
    gas_costs number,
    expenditure_date varchar2(100) not null
);

select * from cost;

