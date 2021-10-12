const updateUser = """
mutation updateUser(\$user_id: uuid!, \$avatar: String ,
  \$birthDate: date!, \$address: String , \$display_name: String!,
  \$gender: String!, \$height: float8!, \$phone: String ,
  \$jop: String , \$weight: float8!,  \$isCompleted:Boolean!) {
  update_user(where: {id: {_eq: \$user_id}},
    _set: {avatar: \$avatar, birthDate: \$birthDate,
      address: \$address, display_name: \$display_name, 
      gender: \$gender, height: \$height, phone: \$phone, 
      jop: \$jop, weight: \$weight,   
       isCompleted: \$isCompleted}) {
    affected_rows
  }
}
""";

const getMyData = """
query getMyData(\$id:uuid!){
  user_by_pk(id: \$id) {
    address
    avatar
    birthDate
    display_name
    gender
    height
    jop
    phone
    weight
  }
}
""";

const getUseByEmail = """
query getUserByEmail (\$email :String!) {
  user(where: {email: {_eq: \$email}}) {
    display_name
    isDoctor
    isCompleted
    isActivated
    avatar
    id
  }
}
""";

const updateUserToken = """
      mutation updateToken(\$token: String! , \$user:uuid!) {
        update_user(_set: {token: \$token}, where: {id: {_eq: \$user}}) {
          affected_rows
        }
      }
""";

const insertUser = """
mutation insertUser(\$email:String! , \$name:String! , \$avatar:String!) {
  user: insert_user(objects: {email: \$email , display_name:\$name , avatar:\$avatar}) {
    returning {
      display_name
      isDoctor
      isCompleted
      isActivated
      avatar
      id
    }
  }
}
""";
