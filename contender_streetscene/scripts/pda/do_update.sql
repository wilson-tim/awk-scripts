-- do the update of the insp_list table
-- lock table to stop pda seeing an inconsistent list
lock table insp_list in exclusive mode;
-- move the current active ('A') list to delete ('D')
update insp_list set state = 'D'
  where (state = 'A' or state = 'P');
-- move the waiting ('W') list to active ('A')
update insp_list set state = 'A'
  where state = 'W';
-- allow pda to see the new inspection list
unlock table insp_list;
-- delete the delete list (state = 'D')
delete from insp_list
  where state = 'D';


