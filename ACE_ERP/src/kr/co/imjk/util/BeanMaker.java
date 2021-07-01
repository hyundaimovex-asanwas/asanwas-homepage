package kr.co.imjk.util;

/**
 * BeanMaker.java 

 *
 * @ author : hslim
 * @ e-mail : hslim@imjk.co.kr
 * @ create-date : 2001-07-16 16:50
 * @ modify-date : 2001-08-07
 *
 */ 
 
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.StringTokenizer;

import kr.co.imjk.lib.db.DBHandler;


public class BeanMaker{

    /**
     * 
     * @uml.property name="db"
     * @uml.associationEnd 
     * @uml.property name="db" multiplicity="(1 1)"
     */
    private DBHandler db = DBHandler.getInstance();

    private String dir_path; // "/home/weblogic/bea2/wlserver6.1/config/howkey/applications/hk05/temp/";
    private String package_name;
    private String table_name;
    
    // table information
    private int column_type [] = null;
    private String column_name [] = null;
    private String column_type_name [] = null;  
    private StringBuffer msg; 
    
    private PrintWriter out;     
    
    public BeanMaker(String dir_path, String package_name, String table_name){
        this.dir_path = dir_path;
        this.package_name = package_name;
        this.table_name = table_name;
        
        msg = new StringBuffer();
    }
    
    // DB Query
    public void go(){
        
        String sql = "select * from "+table_name +" where rownum < 1 ";
        Statement stmt = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        
        // DB Connection
        Connection con = null;
        int column_count = 0;
        
        try{
            con = db.getConnection();
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);            
            rsmd = rs.getMetaData();
            column_count = rsmd.getColumnCount();
            column_type = new int[column_count];
            column_name = new String[column_count];
            for(int i=0; i<column_count; i++){
                column_type[i] = rsmd.getColumnType(i+1);
                column_name[i] = (rsmd.getColumnName(i+1)).toLowerCase();
            }
            rs.close();
            stmt.close();
            msg.append("1. 데이터 베이스로 부터 "+table_name+" 테이블의 정보를 가져왔습니다.");
            msg.append("<br>");
        }catch(Exception e){
            msg.append(Util.getStackTrace(e));
            return;
        }finally{
            try{
                if(stmt != null) stmt.close();
                if(con != null) con.close();
            }catch(SQLException _ignored){}
        }
        
        setColumnType(column_type);
        
        if(init()){
            start();
        }        
    }   
    
    private void setColumnType(int []column_type){
        column_type_name = new String[column_type.length];
        for(int i=0; i<column_type.length; i++){
            int column = column_type[i];
            if(column == Types.VARCHAR || column == Types.CHAR || column == Types.LONGVARCHAR || column == Types.VARBINARY){
                column_type_name[i] = "String";
            }else if(column == Types.DATE || column == Types.TIME  || column == Types.TIMESTAMP){
                column_type_name[i] = "java.util.Date";
            }else if(column == Types.NUMERIC || column == Types.INTEGER){
                column_type_name[i] = "int";
            }else{
                column_type_name[i] = "String";
            }
        }
    } 
    
    private void start(){
        // copyright
        out.println("/**");
        out.println(" * By beans generator source file ");
        out.println(" * source file name : "+table_name+"Bean.java");
        out.println(" * ");
        out.println(" * ### BeanMaker 1.0 ###");
        out.println(" * @author : hslim");
        out.println(" * @date : 2001-07-16 16:50");
        out.println(" * @mail : hslim@imjk.co.kr");
        out.println(" *");
        out.println(" */");
        out.println();
        // package        
        out.println("package "+ package_name + ";");
        out.println();
        // import
        out.println("import com.woorisam.lib.util.Util;");
        out.println();
        // class name
        out.println("public class "+table_name+"Bean{");
        // member variable
        tab();out.println("// MEMBER VARIABLE");
        for(int i=0; i<column_name.length; i++){
            tab();out.println("private "+column_type_name[i] +" "+ column_name[i]+";");
        }
        out.println();
        // construct
        tab();out.println("// CONSTRUCT");
        tab();out.println("public "+table_name+"Bean(){");
        tab();tab();out.println("");
        tab();out.println("}");
        out.println();
        // setter
        tab();out.println("// STTER");   
        for(int i=0; i<column_name.length; i++){  
            tab();out.println("public void set"+getSetter(i)+"("+column_type_name[i]+" "+column_name[i]+"){");
            tab();tab();out.println("this."+column_name[i]+" = "+column_name[i]+";");
            tab();out.println("}");
        }
        out.println();
        // gatter        
        tab();out.println("// GATTER");        
        for(int i=0; i<column_name.length; i++){   
            if(column_type_name[i].equals("java.util.Date")){
                tab();out.println("// DateType 'yyyy-MM-dd'");
                tab();out.println("public String get"+getSetter(i)+"_String(){");
                tab();tab();out.println("return Util.dateToString("+column_name[i]+", \"yyyy-MM-dd\");");
                tab();out.println("}");
            }
            
            tab();out.println("public "+(column_type_name[i])+" get"+getSetter(i)+"(){");
            if(column_type_name[i].indexOf("String") > -1){
                tab();tab();out.println("return Util.getString(this."+column_name[i]+", \"\");");
            }else{
                tab();tab();out.println("return this."+column_name[i]+";");
            }

            tab();out.println("}");
        }        
        out.println("}");
        out.flush();
        out.close();
        msg.append("3. "+table_name+"Bean 클래스의 소스파일을 생성하였습니다.");
        msg.append("<br>");
        msg.append("4. 작업이 완료되었습니다.");
        msg.append("<br>");
        msg.append("5. 소스파일명 : "+table_name+"Bean.java");
        msg.append("<br>");
    }

    private boolean init(){
        StringBuffer tmp = new StringBuffer();
        StringTokenizer st = new StringTokenizer(table_name, "_");
        while(st.hasMoreElements()){
            String s = st.nextToken();
            tmp.append(s.substring(0, 1).toUpperCase() + s.substring(1)); 
        }
        table_name = tmp.toString();
       
        /*
        File f = new File(table_name + "Bean.java");
        if(f.exists()){
            msg.append("3. "+table_name+"Bean.java 와 동일한 파일명이 존재합니다.");
            msg.append("<br>");
            msg.append("4. 프로그램을 종료합니다.");
            msg.append("<br>");
            return false;  
        }
        */
    
        try {
            out = new PrintWriter(new FileWriter(dir_path + table_name+"Bean.java", false), true);
        }catch (IOException e) {
            msg.append("Can't create the class file: " + table_name +"Bean.java");
            msg.append("<br>");
        }
        msg.append("2. "+table_name+" 클래스의 소스를 저장할 파일을 열었습니다.");
        msg.append("<br>");
        return true;
    }    

    private void tab(){
        out.print("    ");  
    }

    private String getSetter(int i){
        return   (column_name[i].substring(0,1)).toUpperCase() + column_name[i].substring(1, column_name[i].length());
    }
    
    public String getMessage(){
        return msg.toString();
    }
    
    public String getFileName(){
        return table_name + "Bean.java";
    }
}


