using System;
using System.Security.Cryptography;
using System.Text;

namespace MobileCenter.Classes
{
    internal static class Credentials
    {
        private const string PasswordAlphabet = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789-";
        private const int GeneratedPasswordLength = 8;
        private const int SmsCodeMinValue = 100000;
        private const int SmsCodeMaxValueExclusive = 1000000;

        private static readonly RandomNumberGenerator Rng = new RNGCryptoServiceProvider();

        /// <summary>
        /// Hash format stored in Users.password (unsalted MD5, lowercase hex) — kept for compatibility with existing accounts.
        /// </summary>
        public static string HashPassword(string password)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] hash = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
                var hex = new StringBuilder(hash.Length * 2);
                foreach (byte value in hash)
                {
                    hex.Append(value.ToString("x2"));
                }

                return hex.ToString();
            }
        }

        public static string GeneratePassword()
        {
            var chars = new char[GeneratedPasswordLength];
            for (int i = 0; i < chars.Length; i++)
            {
                chars[i] = PasswordAlphabet[NextInt(0, PasswordAlphabet.Length)];
            }

            return new string(chars);
        }

        /// <summary>Six-digit code sent by SMS to confirm a phone number.</summary>
        public static int GenerateSmsCode()
        {
            return NextInt(SmsCodeMinValue, SmsCodeMaxValueExclusive);
        }

        // Uniform integer in [minValue, maxValue); rejection sampling avoids modulo bias.
        private static int NextInt(int minValue, int maxValue)
        {
            uint range = (uint)(maxValue - minValue);
            uint limit = uint.MaxValue - uint.MaxValue % range;
            var buffer = new byte[4];
            uint value;
            do
            {
                Rng.GetBytes(buffer);
                value = BitConverter.ToUInt32(buffer, 0);
            }
            while (value >= limit);

            return (int)(minValue + value % range);
        }
    }
}
