const getDoctorPatientv="""
query getPatientByDoctor (\$doctor_id:uuid!) {
  user(where: {doctor_id: {_eq: \$doctor_id}}) {
      id
      display_name
      avatar
  }
}
""";

// query getPatientByDoctor (\$doctor_id:uuid!) {
//   reservation(where: {doctor_id: {_eq: \$doctor_id}}) {
//     reservation_patient {
//       avatar
//       id
//       display_name
//     }
//   }
// }