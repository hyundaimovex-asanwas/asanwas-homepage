package pms.news.bud.excel;


import pms.news.bud.excel.Bud025ExcelWRK;
import java.rmi.RemoteException;


import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;


public class Bud025Excel implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		System.out.println("123???????????????");

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
		System.out.println("p_box===="+p_box);
		
		System.out.println("======================================");

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
        
        
        
        
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        System.out.println("ss");
		Bud025ExcelWRK wrk = new Bud025ExcelWRK();


		// S_MODE�� ��ȸ, ����, ������ ���
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.Bud025ExcelCMD_SHR(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV")) {
			
			System.out.println("Bud025Excel SAV.......");

			wrk.Bud025ExcelCMD_SAV(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV_01")) {

			wrk.Bud025ExcelCMD_SAV_01(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV_END")) {

			wrk.Bud025ExcelCMD_SAV_END(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("ULD")) {
			System.out.println("Bud025Excel ULD.......");
			
			if(p_box.get("extension").equals("xls")){
				
				System.out.println("Bud025Excel   xls @@@@@");
				
				wrk.Bud025Excel1CMD_ULD(p_box, p_tr);
				
			}else if(p_box.get("extension").equals("xlsx")){
				System.out.println("222222222222222222222223");
				
				System.out.println("Bud025Excel    xlsx �����@@@@@@@@");
				
				wrk.Bud025Excel2CMD_ULD(p_box, p_tr);
				
			}
			//wrk.Bud025ExcelCMD_ULD(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("ULD2")) {		
			
			System.out.println("181818181818");
			
		}else if (p_box.get("S_MODE").equals("DEL")) {

		    wrk.Bud025ExcelCMD_DEL(p_box, p_tr);

		}        
        
        //EjbProxy.controlTxn(new WELN030EJB(p_box, p_tr));

 	}

}
