# db/seeds.rb

# --- Clear existing data ---
Appointment.delete_all
User.delete_all
Hospital.delete_all

# --- Create Hospitals ---
h1 = Hospital.create!(name: "Lifeline Hospital", address: "123 Main St")
h2 = Hospital.create!(name: "Hope Hospital", address: "456 Green Rd")

# --- Create Doctors ---
d1 = User.create!(name: "Dr. Keerthi", email: "doc1@example.com", password: "123456", role: "doctor", hospital: h1)
d2 = User.create!(name: "Dr. Sapta", email: "doc2@example.com", password: "123456", role: "doctor", hospital: h2)

# --- Create Patients ---
p1 = User.create!(name: "Riya", email: "saptaparnabhattacharjee33@gmail.com", password: "123456", role: "patient")
p2 = User.create!(name: "Aditi", email: "authurukeerthi2610@gmail.com", password: "123456", role: "patient")

# --- Create Appointments (valid dates > 1 day in advance) ---
Appointment.create!(doctor: d1, patient: p1, hospital: h1, date: 2.days.from_now + 1.hour, status: "pending")
Appointment.create!(doctor: d2, patient: p2, hospital: h2, date: 3.days.from_now + 1.hour, status: "pending")

puts "Seed data created successfully!"
