import { drizzle } from "drizzle-orm/node-postgres";
import { migrate } from "drizzle-orm/node-postgres/migrator";
import { Pool } from "pg";

const pool = new Pool({
  connectionString: "postgresql://postgres:test123@db:5432/mydb",
});

const db = drizzle(pool);

async function main() {
  console.log("Migration started");
  await migrate(db, { migrationsFolder: "drizzle" });
  console.log("Migration completed");
  process.exit(0);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
}); 