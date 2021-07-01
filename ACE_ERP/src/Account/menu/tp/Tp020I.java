package Account.menu.tp;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDConstant;		//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
import sales.common.HDUtil;			//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
import sales.common.StringUtil;		//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
import sales.common.SuperServlet;	//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�

//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
public class Tp020I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//������ ��ȸ
		arr_sql[0].append ("{call SALES.GPR_AC_TP020I_01(?,?,?,?,?,   ?) }" );
	
   }

	//init method
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* DataSet */
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
		//System.out.println("init::");
		try {
		    GauceInputStream gis = greq.getGauceInputStream();
	        GauceOutputStream gos = gres.getGauceOutputStream();
	            
	       //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
	        GauceDataSet[] dSets = gis.readAllOutput(); 

			
	        for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default

            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "02");
						cstmt.setString(2, "A19900201");
						cstmt.setString(3, "081102");
						cstmt.setString(4, "1");
						cstmt.setString(5, "19990101");
						cstmt.setString(6, "19990101");   
						cstmt.setString(7, "6070001");   
						cstmt.setString(8, "199001");   
						
						// ���ν����� ���� ���� ���ν�����.. ���� ���� ������.. ���...;;;
						cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//����� ���� Ŀ��
						
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(9);	//Ŀ�� OUT param. 					
						
						//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
						//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
						gos.write(getDataSet(rs, ds1));
					}         	
				}
		}catch (SQLException sqle){
			gres.addException(sqle);
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}

	}	
	
	//select method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//System.out.println("select::");
		//StringUtil.printMsg("v_cost_cd",v_cost_cd,this);
		String v_fdcode	        = HDUtil.nullCheckStr(greq.getParameter("v_fdcode"));      	// ����
		String v_fsdat	        = HDUtil.nullCheckStr(greq.getParameter("v_fsdat"));      	    // ��������
		String v_fr_inout_dt 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_inout_dt")); 	// �ⳳ���� ����
		String v_to_inout_dt	= HDUtil.nullCheckStr(greq.getParameter("v_to_inout_dt")); 	// �ⳳ���� ����
		String v_empno	        = HDUtil.nullCheckStr(greq.getParameter("v_empno"));      	// �ۼ���
		
		try {
		    GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput();

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
            	//O:DS_DEFAULT=ds_default
            	if(dSets[i].getName().equals("ds_slipdtl")){
					GauceDataSet ds1 = gis.read("DS_SLIPDTL");

					//System.out.println("v_fdcode::"+v_fdcode);
					//System.out.println("v_fsdat::"+v_fsdat);
					//System.out.println("v_fr_inout_dt::"+v_fr_inout_dt);
					//System.out.println("v_to_inout_dt::"+v_to_inout_dt);
					//System.out.println("v_empno::"+v_empno);
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fdcode);
					cstmt.setString(2, v_fsdat);
					cstmt.setString(3, v_fr_inout_dt);
					cstmt.setString(4, v_to_inout_dt);
					cstmt.setString(5, v_empno);
					// ���ν����� ���� ���� ���ν�����.. ���� ���� ������.. ���...;;;
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
			}
        	gos.close();
		}catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();			
		}
	}
	
	//apply method
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}
}