create or replace PACKAGE history_pkg IS
/******************************************************************************
This package holds the procedures that writes the history into HISTORY_DATA
table each time when the change occured to any column in a table if the history
feature is turned ON the table/column.
These procedures should be called from the BUR trigger on the table that you
intended to capture the history of the changes.
Three different procedures are overloaded to capture the history of various
data types like VARACHAR2,DATE and NUMBER
*******************************************************************************/

PROCEDURE write_history_data
   ( p_unique_id                  in      varchar2
   , p_tab_num                    in      number
   , p_col_num                    in      number
   , p_old_parm                   in      number
   , p_new_parm                   in out  number
   );
PROCEDURE write_history_data
   ( p_unique_id                  in      varchar2
   , p_tab_num                    in      number
   , p_col_num                    in      number
   , p_old_parm                   in      varchar2
   , p_new_parm                   in out  varchar2
   );
PROCEDURE write_history_data
   ( p_unique_id                  in      varchar2
   , p_tab_num                    in      number
   , p_col_num                    in      number
   , p_old_parm                   in      date
   , p_new_parm                   in out  date
);
--
END history_pkg;
/
show errors
--
create or replace PACKAGE BODY history_pkg IS

PROCEDURE insert_history_data
( p_phist_rec       IN    history_data%ROWTYPE) IS
   --
   --This procedure is to capture the history of the changes into HISTORY_DATA
   --table.
   CURSOR c_appHist IS
      SELECT ahc.data_type_code col_type
           , ahc.hist_flag
       FROM appl_hist_col ahc
           ,appl_hist_table aht
      WHERE ahc.appl_hist_table_num = aht.appl_hist_table_num
        AND aht.appl_hist_table_num = p_phist_rec.appl_hist_table_num
        AND ahc.appl_hist_col_num = p_phist_rec.appl_hist_col_num;
        
   v_appHist              c_appHist%ROWTYPE;
   --
BEGIN

      OPEN c_appHist;
      FETCH c_appHist INTO v_appHist;
      CLOSE c_appHist;

      if v_appHist.hist_flag = 'Y' then
      
      
                 insert into HISTORY_DATA
                    (appl_hist_table_num,
                     PARENT_UNIQUE_KEY,
                     appl_hist_col_num,
                     alpha_from_value,
                     alpha_to_value,
                     data_type_code,
                     date_from_value,
                     date_to_value,
                     num_from_value,
                     num_to_value
                    )
                 values
                    (p_phist_rec.appl_hist_table_num,
                     p_phist_rec.PARENT_UNIQUE_KEY,
                     p_phist_rec.appl_hist_col_num,
                     p_phist_rec.alpha_from_value,
                     p_phist_rec.alpha_to_value,
                     v_appHist.col_type,
                     p_phist_rec.date_from_value,
                     p_phist_rec.date_to_value,
                     p_phist_rec.num_from_value,
                     p_phist_rec.num_to_value
                    );
      end if; 
      
END insert_history_data;

/* Overloaded procedure to handle varchars */
PROCEDURE write_history_data
   ( p_unique_id      in      varchar2
   , p_tab_num        in      number
   , p_col_num        in      number
   , p_old_parm       in      varchar2
   , p_new_parm       in out  varchar2
   ) IS
   
   l_pendHist_rec      history_data%ROWTYPE;

BEGIN

   IF (NVL(p_new_parm,'~') != NVL(p_old_parm,'~')) THEN
      l_pendHist_rec.PARENT_UNIQUE_KEY := p_unique_id;
      l_pendHist_rec.appl_hist_table_num := p_tab_num;
      l_pendHist_rec.appl_hist_col_num := p_col_num;

      l_pendHist_rec.alpha_from_value := p_old_parm;
      l_pendHist_rec.alpha_to_value := p_new_parm;
      --  default in the others
      l_pendHist_rec.date_from_value := NULL;
      l_pendHist_rec.date_to_value := NULL;
      l_pendHist_rec.num_from_value := NULL;
      l_pendHist_rec.num_to_value := NULL;

      --dbms_output.put_line('type = VC'); -- debug
      insert_history_data( l_pendHist_rec);
      
   END IF;
   
END write_history_data;

/* Overloaded procedure to handle numbers */
PROCEDURE write_history_data
   ( p_unique_id      in      varchar2
   , p_tab_num        in      number
   , p_col_num        in      number
   , p_old_parm       in      number
   , p_new_parm       in out  number
   ) IS
   l_pendHist_rec      history_data%ROWTYPE;
   l_nvl_num           number := -999999999;
BEGIN

   IF (NVL(p_new_parm, l_nvl_num) != NVL(p_old_parm, l_nvl_num)) THEN
      l_pendHist_rec.PARENT_UNIQUE_KEY := p_unique_id;
      l_pendHist_rec.appl_hist_table_num := p_tab_num;
      l_pendHist_rec.appl_hist_col_num := p_col_num;

      l_pendHist_rec.num_from_value := p_old_parm;
      l_pendHist_rec.num_to_value := p_new_parm;
      --  Default in the others
      l_pendHist_rec.alpha_from_value := NULL;
      l_pendHist_rec.alpha_to_value := NULL;
      l_pendHist_rec.date_from_value := NULL;
      l_pendHist_rec.date_to_value := NULL;

      --dbms_output.put_line('type = NU'); -- debug
      insert_history_data( l_pendHist_rec);
      --  Inserts into pending hist RESET new value to old value!
      p_new_parm := l_pendHist_rec.num_to_value;
   END IF;
   
END write_history_data;

/* Overloaded procedure to handle dates */
PROCEDURE write_history_data
   ( p_unique_id      in      varchar2
   , p_tab_num        in      number
   , p_col_num        in      number
   , p_old_parm       in      date
   , p_new_parm       in out  date
   ) IS
   l_pendHist_rec      history_data%ROWTYPE;
   l_nvl_date            constant date := to_date('01-DEC-1700', 'DD-MON-YYYY');

    BEGIN
    

       IF (NVL(p_new_parm, l_nvl_date) != NVL(p_old_parm, l_nvl_date)) THEN
          l_pendHist_rec.PARENT_UNIQUE_KEY := p_unique_id;
          l_pendHist_rec.appl_hist_table_num := p_tab_num;
          l_pendHist_rec.appl_hist_col_num := p_col_num;

          l_pendHist_rec.date_from_value := p_old_parm;
          l_pendHist_rec.date_to_value := p_new_parm;
          --  default in the others
          l_pendHist_rec.alpha_from_value := NULL;
          l_pendHist_rec.alpha_to_value := NULL;
          l_pendHist_rec.num_from_value := NULL;
          l_pendHist_rec.num_to_value := NULL;

          --dbms_output.put_line('type = D2'); -- debug
          insert_history_data( l_pendHist_rec);
       END IF;
       
    END write_history_data;
    
END history_pkg;
/
show errors