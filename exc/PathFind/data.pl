:- module(data, [teacher/2,
                 student/2,
                 course/2,
                 exam/2,
                 room/2,
                 capacity/2,
                 availability/4,
                 follows/2,
                 teaches/2,
                 course_exam/2,
                 exam_duration/2,
                 exams_start/1,
                 exams_end/1,
                 c_lunch_break/2,
                 c_b2b/2,
                 c_no_exams_in_period/5,
                 c_not_in_period/6,
                 c_same_day/2,
                 c_study_time/2,
                 c_study_penalty/2,
                 c_correction_time/2,
                 c_correction_penalty/2]
         ).

:- discontiguous c_lunch_break/2, c_b2b/2.

exams_start(1).
exams_end(20).

room(r4248, 'Room 4248').
room(r4253, 'Room 4253').
room(r4258, 'Room 4258').

capacity(r4258,18).
capacity(r4248,26).
capacity(r4253,25).

availability(r4253,1,9,15).
availability(r4253,3,9,15).
availability(r4253,4,9,15).
availability(r4253,9,9,15).
availability(r4253,5,9,15).
availability(r4253,7,9,15).
availability(r4253,12,9,15).
availability(r4253,13,9,15).
availability(r4248,Day,9,14) :- exams_start(FD),exams_end(ED),between(FD,ED,Day).
availability(r4258,Day,15,20) :- exams_start(FD),exams_end(ED),between(FD,ED,Day). % Room 4258 is available from 15 to 20

teacher(t1,'prof. Dmitry Irtegov').
teacher(t2,'prof. Denis Miginsky').
teacher(t3,'prof. Alexander Vlasov').
teacher(t4,'prof. Vadim Puzarenko').
teacher(t5,'prof. Yury Zagorulko').
teacher(t6,'prof. Vladimir Berikov').
teacher(t7,'prof. Vladimir Vaskevich').

student(s1,'Dubinskaya Ekaterina').
student(s2,'Zaykov Dmitry').
student(s3,'Karaseva Polina').
student(s4,'Kritchevskaya Valeria').
student(s5,'Leshkevich Vladimir').
student(s6,'Markelov Oleg').
student(s7,'Morozov Simon').
student(s8,'Naidenov Sergey').
student(s9,'Nikiforov Vladislav').
student(s10,'Odintsov Yaroslav').
student(s11,'Oleckh Leonid').
student(s12,'Plotter Arthur').
student(s13,'Plyusnin Artem').
student(s14,'Thromenschlegger Yana').
student(s15,'Ushaev Alexander').
student(s16,'Chernikov Vasily').
student(s17,'Shatalov Ivan').
student(s18,'Yakovlev Arthur').

course(c1,'Operating Systems').
course(c2,'Team Project').
course(c3,'OOP').
course(c4,'Computation Models').
course(c5,'AI: Introdution').
course(c6,'Probability theory').
course(c7,'Differential Calculus').

follows(Student,Course) :- student(Student,_),course(Course,_). % Every student follows every course

teaches(t1,c1).
teaches(t2,c2).
teaches(t3,c3).
teaches(t4,c4).
teaches(t5,c5).
teaches(t6,c6).
teaches(t7,c7).

exam(e1,'Operating Systems').
exam(e2,'Team Project').
exam(e4,'Computation Models').
exam(e5,'AI: Introduction').
exam(e6,'Probability theory').
exam(e7,'Differential Calculus').

course_exam(c1,e1).
course_exam(c2,e2).
course_exam(c4,e4).
course_exam(c5,e5).
course_exam(c6,e6).
course_exam(c7,e7).

% Every exam takes 4 hours at most
exam_duration(Ex,4) :- exam(Ex,_).


% Teachers' constraints
c_lunch_break(Teacher,2) :- teacher(Teacher,_). % All teachers prefer to have a lunch
c_b2b(Teacher,2) :- teacher(Teacher,_). % All teachers prefer not to have 2 exams in a row
c_no_exams_in_period(t1,Day,0,12,2) :- exams_start(FD),exams_end(ED),between(FD,ED,Day). % Dmitry Irtegov prefers no exams before noon
c_no_exams_in_period(t5,Day,0,24,6) :- exams_start(FD),ED is FD + 7,between(FD,ED,Day). % Yury Zagorulko is away during the first week
c_no_exams_in_period(t6,Day,14,24,6) :- exams_start(FD),exams_end(ED),between(FD,ED,Day). % Vladimir Berikov and Vladimir Vaskevich prefer
c_no_exams_in_period(t7,Day,14,24,6) :- exams_start(FD),exams_end(ED),between(FD,ED,Day). % to have an exam before noon
c_not_in_period(t2,e2,Day,0,24,3) :- exams_start(FD),ED is FD + 10,between(FD,ED,Day). % Team project preferrably not to be held in first 10 days
c_correction_time(Exam,0) :- exam(Exam,_). % No exams require correction time
c_correction_penalty(Teacher,0) :- teacher(Teacher,_). % Require enough correction time

% Students' constraints
c_lunch_break(Student,2) :- student(Student,_). % All students prefer to have a lunch
c_b2b(Student,5) :- student(Student,_). % All students strongly prefer NOT to have 2 exams in a row
c_same_day(Student,3) :- student(Student,_). % All students prefer not to have more than 1 exam on the same day
c_study_time(Exam,4) :- exam(Exam,_). % All exams require 4 days to study
c_study_penalty(Student,5) :- student(Student,_). % Require enough study time
