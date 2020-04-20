const createReservation = """
mutation addReservation (\$payment_image:String!,\$patient_id:uuid!
\$doctor_id:uuid!,\$reservation_sessions: reservation_sessions_arr_rel_insert_input !) {
  insert_reservation(objects: {payment_image: \$payment_image,
    patient_id: \$patient_id, doctor_id: \$doctor_id,
     reservation_sessions: \$reservation_sessions}) {
    affected_rows
  }
}
""";

const getReservationSessionsByReservationStatus = """
query getReservationSessionsByReservationStatus(\$reservation_status: reservation_status_enum!) {
  reservation(where: {reservation_status: {_eq: \$reservation_status}}) {
    reservation_sessions {
      reservation_id
      session_date
      call_from
      call_to
      id
      session_index
      session_status
      session_time
    }
  }
}
""";

const getPatientReservationByStatus = """
query getPendingReservation(\$patientId: uuid!, \$reservateionStatus: reservation_status_enum!) {
  reservation(where: {patient_id: {_eq: \$patientId}, reservation_status: {_eq: \$reservateionStatus}}) {
    payment_image
    created_at
    reservation_sessions {
      session_date
      session_index
      session_time
      call_from
      call_to
      reservation_id
      session_status
    }
  }
}
""";
