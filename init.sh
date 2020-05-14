echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system



// update User Data 

mutation updateUser($user_id: uuid!, $avatar: String!,
  $birthDate: date!, $address: String!, $display_name: String!,
  $gender: String!, $height: float8!, $phone: String!,
  $jop: String!, $weight: float8!, $userType: String!,$pushToken:String!,$isCompleted:Boolean!) {
  update_user(where: {id: {_eq: $user_id}},
    _set: {avatar: $avatar, birthDate: $birthDate,
      address: $address, display_name: $display_name, 
      gender: $gender, height: $height, phone: $phone, 
      jop: $jop, weight: $weight, userType: $userType, 
      pushToken: $pushToken, isCompleted: $isCompleted}) {
    affected_rows
  }
}
 ----------------------------------------------------------
// Add reservation 

mutation addReservation ($payment_image:String!,$patient_id:uuid!
$doctor_id:uuid!,$reservation_status:reservation_status_enum!,$reservation_sessions:reservation_sessions_arr_rel_insert_input!) {
  insert_reservation(objects: {payment_image: $payment_image,
    patient_id: $patient_id, doctor_id: $doctor_id,
    reservation_status: $reservation_status, reservation_sessions: $reservation_sessions}) {
    affected_rows
  }
}

------------------------------------------------
// change Reservation Status

mutation changeReservationStatus($reservarion_id: Int!, $reservation_status: reservation_status_enum!) {
  update_reservation(where: {id: {_eq: $reservarion_id}}, _set: {reservation_status: $reservation_status}) {
    affected_rows
  }
}
--------------------------
// Change session date and time 

mutation changeSessionDateAndTime($session_id: Int!, $date: date!, $time: timetz!) {
  update_reservation_sessions(where: {id: {_eq: $session_id}},
    _set: {session_date: $date, session_time: $time}) {
    affected_rows
  }
}
--------------------------------
// Change session status

mutation changeSessionStatus($session_id: Int!, $status:sessions_status_enum) {
  update_reservation_sessions(where: {id: {_eq: $session_id}}, _set: {session_status: $status}) {
    affected_rows
  }
}
------------------------
// update call from
mutation updateCallfrom($session_id: Int!,$callFrom:timetz!) {
  update_reservation_sessions(where: {id: {_eq: $session_id}}, _set: {call_from: $callFrom}) {
    affected_rows
  }
}
----------------
// update call to

mutation updateCallfrom($session_id: Int!, $callTo: timetz!) {
  update_reservation_sessions(where: {id: {_eq: $session_id}}, _set: {call_to: $callTo}) {
    affected_rows
  }
}
-----------------------
//get Patient Sessions Date With all Doctors

query getPatientSessionsDateWithDoctors($patient_id: uuid!) {
  reservation(where: {patient_id: {_eq: $patient_id}}) {
    reservation_sessions {
      session_date
    }
  }
}
---------------------
//get All Session Messages

subscription getAllSessionMessages($session_id: Int!) {
  reservation_sessions(where: {id: {_eq: $session_id}}) {
    reservation_sessions_chat {
      message_type
      message
    }
  }
}
---------------------------
//Reservation Sessions Date Between Doctor And Patient

query getReservationSessionsDateBetweenDoctorAndPatient($patient_id: uuid!, $doctor_id: uuid!) {
  reservation(where: {patient_id: {_eq: $patient_id}, doctor_id: {_eq: $doctor_id}}) {
    reservation_sessions {
      session_date
      id
    }
  }
}
------------------------------
// get Reservation Sessions By Reservation Status

query getReservationSessionsByReservationStatus($reservation_status: reservation_status_enum!) {
  reservation(where: {reservation_status: {_eq: $reservation_status}}) {
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

----------------------------------
// get Reservation Sessions By Reservation Status pending

query getReservationSessionsByReservationStatusPending{
  reservation(where: {reservation_status: {_eq: pending}}) {
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
---------------------------------------
// get Reservation Sessions By Reservation Status accepted

query getReservationSessionsByReservationStatusaccepted{
  reservation(where: {reservation_status: {_eq: accepted}}) {
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
-------------------------------------------
// get Reservation Sessions By Reservation Status archived

query getReservationSessionsByReservation
Statusarchived{
  reservation(where: {reservation_status: {_eq: archived}}) {
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
------------------------
// insert Session Messages

mutation insertSessionMessages ($session_id:Int!,$message:String!,$message_type:message_type_enum!) {
  insert_session_chat(objects: {session_id: $session_id,
    message: $message, message_type: $message_type}) {
    affected_rows
  }
}
------------------------------
// get Reservation By Status With Patient Data

query getReservationByStatusWithPatientData($status: reservation_status_enum!) {
  reservation(where: {reservation_status: {_eq: $status}}) {
    reservation_sessions {
      call_from
      call_to
      id
      reservation_id
      session_date
      session_index
      session_status
      session_time
    }
    reservation_patient {
      id
      avatar
      display_name
    }
  }
}
-----------------------------------
// get Reservation Sessions By Date And Doctor With Patient Data

query getReservationSessionsByDateAndDoctorWithPatientData($session_date: date!, $doctor_id: uuid!) {
  reservation(where: {reservation_sessions: {session_date: {_eq: $session_date}}, doctor_id: {_eq: $doctor_id}}) {
    reservation_sessions(order_by: {session_status: asc}) {
      call_from
      call_to
      id
      reservation_id
      session_date
      session_index
      session_status
      session_time
    }
    reservation_patient {
      id
      avatar
      display_name
    }
  }
}
--------------------------------------------------------------
// get Reservation Sessions Date And PatientData
query getReservationSessionsDateAndPatientData($session_date: date!, $doctor_id: uuid!) {
  reservation(where: {reservation_sessions: {session_date: {_eq: $session_date}}, doctor_id: {_eq: $doctor_id}}) {
    reservation_sessions(order_by: {session_status: asc}) {
      session_date
    }
    reservation_patient {
      id
      avatar
      display_name
    }
  }
}
----------------------------------------
// update Session Status And Create Session
mutation updateSessionStatusAndCreateSession($date: date!, $time: timetz!, $reservation_id: Int!, $status: sessions_status_enum!) {
  insert_reservation_sessions(objects: {reservation_id: $reservation_id, session_date: $date, session_time: $time}) {
    affected_rows
  }
  update_reservation_sessions(where: {reservation_id: {_eq: $reservation_id}}, _set: {session_status: $status}) {
    affected_rows
  }
}

-----------------------------------------------
//////////////New///////////////////////////
query getReservationDetails($filter: reservation_bool_exp!) {
  reservation(where: $filter, limit: 15, order_by: {created_at: asc}) {
    patient_id
    reservation_status
    payment_image
    doctor_id
    reservation_sessions(order_by: {session_date: desc}) {
      call_from
      call_to
      count_down
      reservation_id
      session_date
      session_index
      session_status
      session_time
      starting_today
      is_done
    }
  }
}

-----------------------------------------------------
query getUserDetails($user_id: uuid!) {
  user(where: {id: {_eq: $user_id}}) {
    address
    avatar
    birthDate
    display_name
    doctor_id
    email
    gender
    height
    isDoctor
    jop
    phone
    pushToken
    userType
    weight
  }
}
//////////////////////////////////////
query getReservationSessions($patient_id: uuid!) {
  reservation_sessions(order_by: {session_date: asc}, where: {sessions_reservation: {patient_id: {_eq: $patient_id}}}) {
    session_status
    session_index
    session_date
    session_time
    starting_today
    is_done
    count_down
    call_to
    call_from
    reservation_id
  }
}
--------------------------------------------------
query getReservationSessions($session_id: Int!) {
  session_chat(where: {session_id: {_eq: $session_id}}) {
    message
    message_type
    session_id
    id
    created_at
  }
}

--------------------------------
query getPatientByDoctor ($doctor_id:uuid!) {
  reservation(where: {doctor_id: {_eq: $doctor_id}}) {
    reservation_patient {
      avatar
      id
      display_name
    }
  }
}


