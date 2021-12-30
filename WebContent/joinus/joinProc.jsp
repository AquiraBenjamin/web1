<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.db.DBcon"%>
<%@page import="oracle.jdbc.driver.DBConversion"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>joinProc.jsp</h3>
<%
request.setCharacterEncoding("utf-8");
String id=request.getParameter("id");
String pwd=request.getParameter("pwd");
String pwd2=request.getParameter("pwd2");
String name=request.getParameter("name");
String gender=request.getParameter("gender");

String year=request.getParameter("year");
String month=request.getParameter("month");
String day=request.getParameter("day");
String birth=String.format("%s-%s-%s", year, month, day);

String IsLunar=request.getParameter("IsLunar");
String cphone=request.getParameter("cphone");
String email=request.getParameter("email");

//String habit=request.getParameter("hobby");
String[] habits=request.getParameterValues("hobby");
String habit="";
if(habits!=null){
 for(int i=0; i<habits.length; i++){
	habit+=habits[i];
	if(habits.length>i+1)
		habit+=",";
	}
}
//out.println(habit+"<br>");

List<String> errors=new ArrayList();
if(id==null || id.equals("")){
	errors.add("아이디 없슴");
}
if(!(pwd.equals(pwd2))){
	errors.add("비밀번호 불일치");
}
if(errors.size()>0){//*******important
	request.setAttribute("errors", errors);

	//response.sendRedirect("join.jsp");
	request.getRequestDispatcher("join.jsp").forward(request, response);
}else{
	 String sql="insert into member "
	+"(id,pwd,name,gender,birth,is_lunar,cphone,email,habit,regdate)"
	+"values(?,?,?,?,?,?,?,?,?,sysdate)";
	
	Connection con=DBcon.getConnection();
	
	PreparedStatement pstmt=con.prepareStatement(sql); 
	pstmt.setString(1, id);
	pstmt.setString(2, pwd);
	pstmt.setString(3, name);
	pstmt.setString(4, gender);
	pstmt.setString(5, birth);
	pstmt.setString(6, IsLunar);
	pstmt.setString(7, cphone);
	pstmt.setString(8, email);
	pstmt.setString(9, habit);
	
	pstmt.executeUpdate();//insert
	
	//mainpage
	response.sendRedirect("../index.jsp");
}

%>











</body>
</html>