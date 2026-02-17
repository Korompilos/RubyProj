# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#dummy data 

25.times do |i|

  User.create!(

    email: "user#{i+1}@example.com",

    password: "123456",

    password_confirmation: "123456"

  )

end

puts "Δημιουργήθηκαν 25 dummy users!"

puts "--- Ξεκινάει η διαδικασία Seeding ---"

25.times do |i|
  email = "user#{i+1}@example.com"
  User.find_or_create_by!(email: email) do |user|
    user.password = "123456"
    user.password_confirmation = "123456"
  end
end
puts "✅ Ελέγχθηκαν/Δημιουργήθηκαν 25 dummy users."

u1  = User.find_by(email: "user1@example.com")
u3  = User.find_by(email: "user3@example.com")
u7  = User.find_by(email: "user7@example.com")
u16 = User.find_by(email: "user16@example.com")

if u1 && u3 && u7 && u16
  puts "📝 Δημιουργία συζητήσεων..."

  # --- ALGEBRA I ---
  Post.create!(user: u1, category: "Algebra I", content: "Παιδιά έχει λύσει κανείς την άσκηση 4 στη σελίδα 102; Κολλάω στον υπολογισμό των ιδιοτιμών, μου βγαίνουν μιγαδικοί.")
  Post.create!(user: u3, category: "Algebra I", content: "Την έλυσα εγώ χθες. Μην ξεχάσεις να βγάλεις κοινό παράγοντα το λ πριν κάνεις την ορίζουσα. Δες το πρόσημο!")
  Post.create!(user: u7, category: "Algebra I", content: "Εγώ ακόμα παλεύω με τους αντίστροφους πίνακες... Με βλέπω να το χρωστάω τον Σεπτέμβρη το μάθημα.")
  Post.create!(user: u16, category: "Algebra I", content: "Αν θέλετε, έχω κρατήσει σημειώσεις από το φροντιστήριο για τον αλγόριθμο Gauss. Να τις ανεβάσω;")

  # --- DATABASES ---
  Post.create!(user: u1, category: "Databases", content: "Ρε παιδιά, στο Project, η σχέση 'Φοιτητής' με 'Μάθημα' είναι One-to-Many ή Many-to-Many;")
  Post.create!(user: u16, category: "Databases", content: "Many-to-Many είναι. Ένας φοιτητής παίρνει πολλά μαθήματα και ένα μάθημα έχει πολλούς φοιτητές. Θες ενδιάμεσο πίνακα.")
  Post.create!(user: u3, category: "Databases", content: "Σωστά. Φτιάξε πίνακα Grades που θα έχει τα ID και των δύο ως Foreign Keys.")
  Post.create!(user: u7, category: "Databases", content: "Εγώ μόλις έκανα DROP TABLE users κατά λάθος και έχασα τα δεδομένα μου... SOS πώς κάνω undo στο pgAdmin;")

  # --- OPERATING SYSTEMS ---
  Post.create!(user: u1, category: "Operating Systems", content: "Ποιος κατάλαβε τον αλγόριθμο του Τραπεζίτη (Banker's Algorithm) για τα Deadlocks;")
  Post.create!(user: u7, category: "Operating Systems", content: "Εγώ χάθηκα τελείως στη διάλεξη σήμερα. Κάτι για resources έλεγε αλλά δεν έβγαλα άκρη.")
  Post.create!(user: u16, category: "Operating Systems", content: "Είναι απλό: Το σύστημα ελέγχει αν έχει αρκετούς πόρους για να ικανοποιήσει ένα process πριν το δεσμεύσει. Σαν δάνειο στην τράπεζα.")
  Post.create!(user: u3, category: "Operating Systems", content: "Έχω γράψει ένα script σε C που το εξομοιώνει. Το ανέβασα στο GitHub, τσεκάρετε το link στο προφίλ μου.")

  # --- C# ---
  Post.create!(user: u1, category: "C#", content: "Visual Studio error: 'Object reference not set to an instance of an object'. Τι σημαίνει αυτό; Το βγάζει συνέχεια!")
  Post.create!(user: u3, category: "C#", content: "Κλασικό NullReferenceException. Προσπαθείς να χρησιμοποιήσεις μια μεταβλητή που είναι null. Έκανες new στο αντικείμενο;")
  Post.create!(user: u16, category: "C#", content: "Βάλε ένα breakpoint στη γραμμή 45 και δες αν η λίστα σου έχει αρχικοποιηθεί.")
  Post.create!(user: u7, category: "C#", content: "Εμένα μου τρέχει αλλά δεν εμφανίζει το παράθυρο... Μάλλον ξέχασα το InitializeComponent() στον constructor.")

  puts "✅ Τα Posts δημιουργήθηκαν επιτυχώς!"
else
  puts "❌ Κάποιος χρήστης (user1, 3, 7 ή 16) δεν βρέθηκε. Τα posts δεν δημιουργήθηκαν."
end

puts "--- Τέλος Seeding ---"