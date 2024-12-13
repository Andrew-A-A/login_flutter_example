
class Validator{
  static String? isPasswordValid({required String? password}){
    if(password ==null){
      return null;
    }
    if(password.isEmpty){
      return "Please enter password";
    }else if(password.length<8){
      return "Please enter a valid password";
    }
    return null;
  }
  static String? validateEmail({required String? email}) {
    if(email==null){

      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }
}