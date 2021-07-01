package sales.menu.sy;

import javax.servlet.ServletException;
import sales.common.SuperServlet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;


public class Sy900I extends SuperServlet {

    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Main 조회
		arr_sql[0].append ("{call SALES.PR_SY900I_01(?, ?) }" );
		//Main 저장
		arr_sql[1].append ("{call SALES.PR_SY900I_02(?,?,?,?,?,   ?,?,?,?) }");
   }

	//init method
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	//select method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}
	
	//apply method
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}
}