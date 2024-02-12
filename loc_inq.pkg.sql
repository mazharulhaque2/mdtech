CREATE OR REPLACE PACKAGE loc_inq_pkg IS
  v_pkg_name    varchar2 (30) := upper('loc_inq_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  --
  PROCEDURE get_country_json(p_out  OUT clob);
  --
  PROCEDURE get_country_json_list(p_out  OUT clob);
  --
  PROCEDURE get_location_json(p_out  OUT clob);
  --
  PROCEDURE get_country_ph(p_country_code in country.country_code%type
                          ,p_out  OUT SYS_REFCURSOR);
  --
  PROCEDURE get_CULTURES (p_out OUT SYS_REFCURSOR);
  --
  FUNCTION distance (a_lat in number
                  ,a_lon in number
                  ,b_lat in number
                  ,b_lon in number
                  ,measurement_system_code in varchar2 default 'MS'
                  )
      return number; 
  --
  FUNCTION point_of_interest (p_geonameid in number, p_geojson in clob) RETURN t_poi_tab PIPELINED;
  --
  PROCEDURE addr_parsing_prc(p_addr_json IN CLOB,
                     p_country_code   OUT country.country_code%TYPE,
                     p_state_code     OUT state.state_code%TYPE,
                     p_city_name      OUT city.name%TYPE,
                     p_postal_code    OUT postal.postal_code%TYPE,
                     p_addr_1         OUT addr.addr_1%TYPE,
                     p_addr_2         OUT addr.addr_2%TYPE,
                     p_formatted_addr OUT addr.formatted_addr%TYPE,
                     p_latitude       OUT addr.latitude%TYPE,
                     p_longitude      OUT addr.longitude%TYPE,
                     p_status_code    OUT VARCHAR2
                     ); 
END loc_inq_pkg;
/
SHOW ERRORS
--
CREATE OR REPLACE PACKAGE BODY loc_inq_pkg IS
  FUNCTION point_of_interest (p_geonameid in number, p_geojson in clob) RETURN t_poi_tab PIPELINED
  AS
    l_row        t_poi_obj := t_poi_obj (NULL,NULL);
    --
    j_obj json := json(p_geojson);
    l_obj  json_list;
    l_obj2  json_list;
    l_obj3  json_list;
    l_obj4  json_list;
    l_val json_value;
    l_val2 json_value;
    l_val3 json_value;
    v_str varchar2(1000);
    l_num number;
  BEGIN
    l_obj := json_ext.get_json_list(j_obj, 'coordinates');
    --
    for i in 1..json_ac.array_count(l_obj) loop
      l_val := json_ac.array_get(l_obj,i);
      l_obj2 := json_list(l_val);
      for j in 1..json_ac.array_count(l_obj2) loop
        l_val2 := json_ac.array_get(l_obj2,j);
        l_obj3 := json_list(l_val2);
        for k in 1..json_ac.array_count(l_obj3) loop
          if json_ac.jv_to_char(j_obj.get('type')) = '"MultiPolygon"' then
            l_val3 := json_ac.array_get(l_obj3,k);
            l_obj4 := json_list(l_val3);
            for l in 1..json_ac.array_count(l_obj4) loop
              l_num := json_ac.jv_to_char(json_ac.array_get(l_obj4,l));
              l_row.geonameid := p_geonameid;
              l_row.lat_lon := l_num;
              PIPE ROW (l_row);
            end loop;
          elsif json_ac.jv_to_char(j_obj.get('type')) = '"Polygon"' then
            l_num := json_ac.jv_to_char(json_ac.array_get(l_obj3,k));
            l_row.geonameid := p_geonameid;
            l_row.lat_lon := l_num;
            PIPE ROW (l_row);
          end if;
        end loop;
      end loop;
    end loop;
  END point_of_interest;
  --
  FUNCTION distance (a_lat in number
                    ,a_lon in number
                    ,b_lat in number
                    ,b_lon in number
                    ,measurement_system_code in varchar2 default 'MS'
                    )
    return number
  is
    circum number := 40000; -- kilometers
     pai number := acos(-1);
     a_nx number;
     a_ny number;
     a_nz number;
     b_nx number;
     b_ny number;
     b_nz number;
     inner_product number;
  begin
    if (a_lat=b_lat) and (a_lon=b_lon) then
      return 0;
    else
     a_nx := cos(a_lat*pai/180) * cos(a_lon*pai/180);
     a_ny := cos(a_lat*pai/180) * sin(a_lon*pai/180);
     a_nz := sin(a_lat*pai/180);
    
     b_nx := cos(b_lat*pai/180) * cos(b_lon*pai/180);
     b_ny := cos(b_lat*pai/180) * sin(b_lon*pai/180);
     b_nz := sin(b_lat*pai/180);

      inner_product := a_nx*b_nx + a_ny*b_ny + a_nz*b_nz;

      if inner_product > 1 then
        return 0;
      else
        if measurement_system_code = 'MS' then
          return round(((circum*acos(inner_product))/(2*pai)),2); --Kilometer
        else
          return round(((circum*acos(inner_product))/(2*pai))*0.621371,2); --Miles
        end if;
      end if;
    end if;
  end distance;
  --
  PROCEDURE get_CULTURES (p_out OUT SYS_REFCURSOR) AS 
  BEGIN
    OPEN p_out FOR
    SELECT LANG_CODE CULTURE
          ,descr
    FROM LIST_LANG
    where SUPPORTED_LANG_FLAG = 'Y'
    and active_flag = 'Y'
    ;  
  END get_CULTURES;
  --
  PROCEDURE get_country_ph(p_country_code in country.country_code%type
                          ,p_out  OUT SYS_REFCURSOR) IS
  BEGIN
    open p_out for 
    select c.name country_name
          ,c.country_code
          ,decode(can.PRIMARY_LANG_IND,'P',can.alt_name,null) alt_name
          ,C.PHONE_COUNTRY_CODE
          ,FLAG_IMAGE_FILE_NAME_32 FLAG_IMAGE_FILE_NAME
          ,FLAG_IMAGE_32 FLAG_IMAGE
          ,case 
             when can.PRIMARY_LANG_IND = 'P' then c.name||' ('||to_nchar(C.PHONE_COUNTRY_CODE)||') -'||can.alt_name
             else c.name||' ('||to_nchar(C.PHONE_COUNTRY_CODE)||')'
           end drvd_country_name
    from country c
        ,country_alt_name can
    where C.COUNTRY_CODE = can.COUNTRY_CODE
    and CAN.PRIMARY_LANG_IND in ('P','N')
    and C.PHONE_COUNTRY_CODE is not null
    and (c.country_code = upper(p_country_code) or p_country_code is null)
    order by c.name
    ;
  END get_country_ph;
  --
  PROCEDURE get_country_json(p_out  OUT clob) IS
  ret json;
  BEGIN
    ret := json_dyn.executeObject('select * from country_stg where rownum <=2');
    ret.PRINT;
    dbms_lob.createtemporary(p_out, true);
    ret.to_clob(p_out);
    --
    dbms_output.put_line(p_out);
    dbms_lob.freetemporary(p_out);
    
  END get_country_json;
  --
  PROCEDURE get_country_json_list(p_out  OUT clob) IS
  ret json_list;
  BEGIN
    ret := json_dyn.executeList('select * from country_stg where rownum <=2');
    --ret.PRINT;
    dbms_lob.createtemporary(p_out, true);
    ret.to_clob(p_out);
    dbms_output.put_line(p_out);
    dbms_lob.freetemporary(p_out);
    
  END get_country_json_list;
  --
  PROCEDURE get_location_json(p_out  OUT clob) IS 
    ret json_list;
    continent_clob clob;
    country_clob   clob;
    --p_out        clob;
    --p_out_json json;
  BEGIN
      dbms_lob.createtemporary(p_out, true);
      --Get the continent records into JSON object
      ret := json_dyn.executeList('select continent_code,continent_name from continent_stg');
      --ret.print;
      --Put the continent records in JSON object into clob
      dbms_lob.createtemporary(continent_clob, true);
      ret.to_clob(continent_clob);
      p_out := p_out||'{"country" : '||continent_clob||',';
      --dbms_output.put_line(continent_clob);
      dbms_lob.freetemporary(continent_clob);
      --end of building the continent records into JSON
            
      --Get the country records into JSON object
      ret := json_dyn.executeList('select iso as country_code,country as name from country_stg where rownum <= 2');
      --ret.print;
      dbms_lob.createtemporary(country_clob, true);
      ret.to_clob(country_clob);
      p_out := p_out||'"country" : '||country_clob||'}';
      --p_out_json := json(p_out);
      --p_out_json.print;
      --dbms_output.put_line(country_clob);
      dbms_lob.freetemporary(country_clob);
      --dbms_output.put_line(p_out);
      dbms_lob.freetemporary(p_out);   
  END get_location_json;
  --
  PROCEDURE addr_parsing_prc(p_addr_json IN CLOB,
                             p_country_code   OUT country.country_code%TYPE,
                             p_state_code     OUT state.state_code%TYPE,
                             p_city_name      OUT city.name%TYPE,
                             p_postal_code    OUT postal.postal_code%TYPE,
                             p_addr_1         OUT addr.addr_1%TYPE,
                             p_addr_2         OUT addr.addr_2%TYPE,
                             p_formatted_addr OUT addr.formatted_addr%TYPE,
                             p_latitude       OUT addr.latitude%TYPE,
                             p_longitude      OUT addr.longitude%TYPE,
                             p_status_code    OUT VARCHAR2
                             ) IS
      l_obj           json;
      l_results       json_list;
      l_tempobj       json;
      l_addr_comps    json_list;
      l_addr          json;
      l_typesarr      json_list;
      l_geom_obj      json;
      l_loc           json;
            
           
      l_types         VARCHAR2(30);
      l_short_name    VARCHAR2(200);
      l_street_number VARCHAR2(200);
      l_street        VARCHAR2(200);
      l_city          VARCHAR2(200);
      l_state         VARCHAR2(30);
      l_zip           VARCHAR2(10);
      l_county        VARCHAR2(30);
      l_country       VARCHAR2(10);
      l_lat           VARCHAR2(40);
      l_lng           VARCHAR2(40);
      l_loc_type      VARCHAR2(100);
      l_formatted_addr  VARCHAR2(1000);
      l_place_id      VARCHAR2(100);
      l_status        VARCHAR2(100);
           
      g_pkg_name  VARCHAR2(30)    := 'GEOCODE ADDRESS';
      l_prc_name CONSTANT VARCHAR2(16) := 'GEOCODE ADDRESS';
   
  BEGIN

      -- Create json object from google response
      l_obj    := json(p_addr_json);
           
      -- The overall JSON is an array named results
      l_results := json_list(l_obj.get('results'));
           
      -- There is only a single element in the results array, so get the first (and last) one
      l_tempobj := json(l_results.get(1));
           
      -- The next level contains an array named address_components
      l_addr_comps := json_list(l_tempobj.get(1));
           
      -- loop through the address components and test the types array for address elements
      FOR i IN 1 .. l_addr_comps.count
      LOOP
          l_addr := json(l_addr_comps.get(i));
          --l_addr.print;
               
          l_typesarr := json_list(l_addr.get('types'));
               
          -- Types is not a json array, but a string array so we have to get
          -- the first element using the types[1] syntax
          l_types      := json_ext.get_string(l_addr, 'types[1]');
          l_short_name := json_ext.get_string(l_addr, 'short_name');
               
          CASE l_types
            WHEN 'street_number' THEN
              l_street_number := l_short_name;
            WHEN 'route' THEN
              l_street := l_short_name;
            WHEN 'locality' THEN
              l_city := l_short_name;
            WHEN 'administrative_area_level_1' THEN
              l_state := l_short_name;
            WHEN 'administrative_area_level_2' THEN
              l_county := l_short_name;
            WHEN 'postal_code' THEN
              l_zip := l_short_name;
            WHEN 'country' THEN
              l_country := l_short_name;
            ELSE
              NULL;
          END CASE;
           
      END LOOP;


      -- now get lat/lng
      l_geom_obj := json(l_tempobj.get(3));
      --l_geom_obj.print;
           
      l_loc := json_ext.get_json(l_geom_obj, 'location');
      --l_loc.print;
           
      l_lat := to_char(json_ext.get_number(l_loc, 'lat'));
      l_lng := to_char(json_ext.get_number(l_loc, 'lng'));
                
      --dbms_output.put_line('lat/lng: ' || l_lat || ' ' || l_lng);
      l_loc_type := json_ext.get_string(l_geom_obj, 'location_type');
      --dbms_output.put_line('location_type: ' || l_loc_type);
      l_formatted_addr := json_ext.get_string(l_tempobj, 'formatted_address');
      --dbms_output.put_line('formatted_address: ' || l_formatted_addr);
      l_place_id := json_ext.get_string(l_tempobj, 'place_id');
      --dbms_output.put_line('place_id: ' || l_place_id);
      l_status := json_ext.get_string(l_obj, 'status');
      --dbms_output.put_line('status: ' || l_status);
      
      p_country_code      :=   l_country;
      p_state_code        :=   l_state;
      p_city_name         :=   l_city;
      p_postal_code       :=   l_zip;
      p_addr_1            :=   l_street_number;
      p_addr_2            :=   l_street;
      p_latitude          :=   l_lat;
      p_longitude         :=   l_lng;
      p_formatted_addr    :=   l_formatted_addr;
      p_status_code       :=   l_status;     

  EXCEPTION
    WHEN OTHERS THEN
          common_pkg.ins_appl_process_log (
          g_pkg_name
         ,l_prc_name
         ,'E'
         ,SUBSTR (SQLERRM,1,500)
         ,'ERROR parsing the json for geo address');
      RAISE_APPLICATION_ERROR(-20101,SQLERRM);
  END addr_parsing_prc;             
END loc_inq_pkg;
/
SHOW ERRORS;
--

