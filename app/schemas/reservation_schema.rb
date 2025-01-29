class ReservationSchema
  COMMON_SCHEMA = {
    start_date: [:start_date, 'reservation.start_date'],
    end_date: [:end_date, 'reservation.end_date'],
    nights: [:nights, 'reservation.nights'],
    guests: [:guests, 'reservation.number_of_guests', 'guest_details.localized_description'],
    adults: [:adults, 'reservation.guest_details.number_of_adults'],
    children: [:children, 'reservation.guest_details.number_of_children'],
    infants: [:infants, 'reservation.guest_details.number_of_infants'],
    status: [:status, 'reservation.status_type'],
    currency: [:currency, 'reservation.host_currency', 'currency'],
    payout_price: [:payout_price, 'reservation.expected_payout_amount', 'payout_price'],
    security_price: [:security_price, 'reservation.listing_security_price_accurate', 'security_price'],
    total_price: [:total_price, 'reservation.total_paid_amount_accurate', 'total_price'],
    guest: {
      id: [:id, 'reservation.guest_id', 'guest.id'],
      first_name: [:first_name, 'reservation.guest_first_name', 'guest.first_name'],
      last_name: [:last_name, 'reservation.guest_last_name', 'guest.last_name'],
      email: [:email, 'reservation.guest_email', 'guest.email'],
      phone: [:phone, 'reservation.guest_phone_numbers', 'guest.phone']
    }
  }.freeze
end
