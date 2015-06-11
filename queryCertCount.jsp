<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.formosoft.ms.MSFacade" %>

<%@ page import="java.io.*, com.formosoft.ra.taica2.RAFacade2" %>

<%@ page import="com.formosoft.util.db.DatabaseManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page import="java.util.*" %>
<%@ page import="org.apache.log4j.Logger" %>

<%@ include file="WEB-INF/constants.jsp"%>
<%@ include file="WEB-INF/global.jsp"%>

<%
	String pid = request.getParameter("PID");	
	String ip = "FSMS";
	String CN = "";
	int certCountForMobile = 0;
	//
	Logger 	catLog = Logger.getLogger("queryCertCount.jsp");	
	
	pid = fnToUpperCase(pid);

	if(pid == "" || pid == null){
		catLog.info("-1|PID is empty");
		out.print(-1+"|PID is empty");
		return;
    }
	
	int rtn = -1;
	
	RAFacade2 rao = new RAFacade2(raUrl);
	String sLogMsg = ip;
	String sCertStatus = "0";
	
	rtn = rao.FSRA2_QueryCertEx(pid, null, null, "0", null,null, null, null, null, sLogMsg);
	
	if(rtn == 0){
		int certCount = rao.FSRA2_GetCertCount();
		if(certCount > 0) {					
			//int i = certCount-1;
			for( int i=0; i < certCount; i++ )
			{
				CN = rao.FSRA2_GetCertInfo(i,8);
				if( CN.indexOf("::") > -1 )
					certCountForMobile++;
			}
		}
	}

	out.print(certCountForMobile);	           
%>
